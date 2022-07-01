class OrdersController < ApplicationController
    before_action :get_order_product, only: [:new]

    def new
        @order = Order.new
        @order.product = @product
        @order.uuid = SecureRandom.uuid
        @order.name = @product.name + " 주문"
        @order.price = @product.price
        
        # if not @order.save
        #     render :json => @order.errors.full_messages
        # end
    end

    def create
    end

    def show
    end

    private

    def get_order_product
        @product = Product.find(params[:product_id])
    end
end
