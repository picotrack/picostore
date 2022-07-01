class EmailAuthenticationRequestController < ApplicationController
    skip_before_action :verify_authenticity_token

    def create
        code = rand.to_s[2..7]
        email = params[:email]
        @email_authentication = EmailAuthenticationRequest.new
        @email_authentication.code = code
        @email_authentication.expires_at = DateTime.now + (1.0/(24*60)) * 5
        @email_authentication.used = false
        @email_authentication.save

        OrderMailer.with(email: email, code: code).send_email_authentication_code.deliver_later

        if email
            render :json => {
                :email => email,
                :message => "authentication code is sent to #{email}",
                :email_authentication_id => @email_authentication.id
            }
        else
            render :json => {
                :error => "email is required"
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
