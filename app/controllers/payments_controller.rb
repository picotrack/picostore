class PaymentsController < ApplicationController
    before_action :get_payment_order, only: [:new, :complete]
    before_action :get_payment_product, only: [:new, :complete]
    before_action :get_payment, only: [:complete]

    def new
    end

    def complete
    end

    private

    def get_payment_order
        @order = Order.find(params[:order_id])
    end

    def get_payment_product
        @product = Product.find(params[:product_id])
    end

    def get_payment
        @payment = Payment.find(params[:payment_id])
    end
end
