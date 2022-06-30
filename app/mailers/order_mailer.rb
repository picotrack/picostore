class OrderMailer < ApplicationMailer
    default from: "picomatics@gmail.com"

    def send_email_authentication_code
        @email = params[:email]
        @code = params[:code]
        mail(to: @email)
    end
end
