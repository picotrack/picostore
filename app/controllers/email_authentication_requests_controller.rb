class EmailAuthenticationRequestsController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:create]

    def create
        code = helpers.create_6_digit_code
        email = params[:email]
        @email_authentication = EmailAuthenticationRequest.new
        @email_authentication.code = code
        @email_authentication.expires_at = DateTime.now + (1.0/(24*60)) * 5
        @email_authentication.used = false

        if not @email_authentication.save
            render :json => {
                :message => 'EA 저장 중에 문제가 발생했습니다',
                :errors => @email_authentication.errors.full_messages
            }
        elsif email
            OrderMailer.with(email: email, code: code).send_email_authentication_code.deliver_later

            render :json => {
                :email => email,
                :message => "인증번호가 발송되었습니다",
                :email_authentication_id => @email_authentication.id
            }
        else
            render :json => {
                :message => "이메일을 입력해주세요",
                :other => @code
            }, :status => 400
        end
    end

    def verify
        email_authentication_id = params[:email_authentication_id]
        code = params[:code]
        
        begin
            email_authentication = EmailAuthenticationRequest.find(email_authentication_id)
            if email_authentication.code != code
                render :json => {
                    :message => "인증번호가 틀렸습니다",
                    :code => "#{email_authentication.code} != #{code}" # TODO - remove code
                }, :status => 403
                # TODO - add expiration
                # TODO - add used
            elsif email_authentication.used
                render :json => {
                    :message => "이미 사용된 인증번호입니다",
                }, :status => 410
            else
                email_authentication.used = true
                email_authentication.save
                render :json => {
                    :message => "인증이 완료되었습니다"
                }
            end
        rescue ActiveRecord::RecordNotFound
            render :json => {
                :message => "email authentication request with id #{email_authentication_id} is not found"
            }, :status => 404
        end
    end
end
