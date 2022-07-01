class OrdersController < ApplicationController
    before_action :get_order_product, only: [:new, :create]
    before_action :get_payment_order, only: [:success, :failure]

    def new
        @order = Order.new
        @order.product = @product
        @order.uuid = SecureRandom.uuid
        @order.name = @product.name + " 주문"
        @order.price = @product.price
        
        if not @order.save
            render :json => @order.errors.full_messages
        end
    end

    def set_product_email
    end

    def show
    end

    private

    def get_order_product
        @product = Product.find(params[:product_id])
    end

    def get_payment_order
        @order = Order.where(uuid: params["orderId"]).first
    end
end
