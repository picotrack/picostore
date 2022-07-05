require "external/toss_payments"

class TossPaymentsController < ApplicationController
    # https://docs.tosspayments.com/reference/js-sdk#%EA%B2%B0%EC%A0%9C-%EC%9A%94%EC%B2%AD-%EC%B2%98%EB%A6%AC
    def success
        # https://{ORIGIN}/success?paymentKey={PAYMENT_KEY}&orderId={ORDER_ID}&amount={AMOUNT}

        payment_uuid = params[:paymentKey]
        order_uuid = params[:orderId]
        amount = params[:amount].to_i # querystring은 항상 string

        # check 0: payment_uuid

        # check 1: 해당 uuid인 order 있는지 체크
        @order = Order.where(uuid: order_uuid).first
        if @order == nil
            render :json => {
                :message => "해당 주문은 없는 주문입니다"
            }
            return
        end

        # check 2: 금액이 일치하는지 체크
        if amount != @order.price
            render :json => {
                :message => "결제 금액이 동일하지 않습니다",
                :amount => amount,
                :price => @order.price
            }, status: 403
            return
        end

        @payment = Payment.new
        @payment.order = @order
        @payment.uuid = payment_uuid
        @payment.email = @order.email
        @payment.amount = amount
        @payment.confirmed = false
        @payment.save

        # 토스페이먼츠 연동

        begin
            result = TossPayments.confirm_payment(payment_uuid, order_uuid, amount)
            @payment.confirmed = true
            render :json => {
                message: "결제가 완료되었습니다",
                payment: @payment.to_json,
                result: result
            }
        rescue TossPayments::PaymentConfirmationException => error
            render :json => {
                message: "error!",
                error: error
            }
        end
        
    end

    def failure
        # https://{ORIGIN}/fail?code={ERROR_CODE}&message={ERROR_MESSAGE}&orderId={ORDER_ID}
    end
end
