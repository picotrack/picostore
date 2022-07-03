class PaymentsController < ApplicationController
    def new
        @order = Order.find(params[:order_id])
        @product = Product.find(params[:product_id])
    end
end
