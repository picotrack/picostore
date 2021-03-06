class OrdersController < ApplicationController
    before_action :get_order_product, only: [:new, :create]
    before_action :get_order, only: [:show]

    def new
    end

    def create
        @order_params = params.permit(:email, :customer_name, :code, :email_authentication_id, :product_id)
        
        # Create Order
        @order = Order.new
        @order.product = @product
        @order.uuid = helpers.create_new_uuid
        @order.email = @order_params[:email]
        @order.name = @product.name + " 주문"
        @order.customer_name = @order_params[:customer_name]
        @order.price = @product.price

        if not @order.save
            render :json => {
                :message => "오류가 발생했습니다",
                :error => @order.errors.full_messages
            }, status: 500
            return
        else
            redirect_to controller: "payments", action: "new",
                product_id: @product.id, order_id: @order.id
        end
    end

    def show
    end

    private

    def get_order_product
        @product = Product.find(params[:product_id])
    end

    def get_order
        @order = Order.find(params[:id])
    end
end
