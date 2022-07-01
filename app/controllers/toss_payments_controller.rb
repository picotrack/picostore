class TossPaymentsController < ApplicationController
    def success
        @order.email = params[:email]
        @payment_key = params[:paymentKey]
        @order_id = params[:orderId]
        @amount = params[:amount]
        render :json => {
            :params => params,
            :order => @order,
        }
    end

    def failure
    end
end
