require "faraday"
require "base64"

# response.code
# response.body

module TossPayments
    class PaymentConfirmationException < Exception
    end

    def self.encode_secret_key
        Base64.encode64(ENV["TOSS_PAYMENTS_SECRET_KEY"]+":").strip
    end

    # https://docs.tosspayments.com/reference/error-codes#%EA%B2%B0%EC%A0%9C-%EC%8A%B9%EC%9D%B8-api
    def self.confirm_payment(paymentKey, orderId, amount)
        conn = Faraday.new(url: "https://api.tosspayments.com")

        response = conn.post("/v1/payments/confirm") do |req|
            req.headers["Authorization"] = "Basic #{encode_secret_key}"
            req.headers["Content-Type"] = "application/json"
            req.body = {
                "paymentKey" => paymentKey,
                "orderId" => orderId,
                "amount" => amount
            }.to_json
        end

        # https://lostisland.github.io/faraday/middleware/raise-error

        if response.status == 400
            raise PaymentConfirmationException.new(response.body)
        else
            return response.body
        end
    end
end