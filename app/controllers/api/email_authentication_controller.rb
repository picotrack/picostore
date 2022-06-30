class Api::EmailAuthenticationController < ApplicationController
    def request_email_authentication
        code = rand.to_s[2..7]
        email = params[:email]
        @email_authentication = EmailAuthenticationRequest.new
        @email_authentication.code = code
        @email_authentication.expires_at = DateTime.now + (1.0/24)
        @email_authentication.save

        OrderMailer.with(email: email, code: code).send_email_authentication_code.deliver_now

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

    def verify_email_authentication
    end
end
