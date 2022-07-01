class OrdersController < ApplicationController
    before_action :get_product, only: [:new, :create]

    def new
        @order = Order.new
        @order.price = @product.price
        @order.uuid = SecureRandom.uuid
        @order.name = @product.name + " 주문"
    end

    def create
    end

    def show
    end

    private

    def get_product
        @product = Product.find(params[:product_id])
    end
end
