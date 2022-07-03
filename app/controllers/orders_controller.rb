class OrdersController < ApplicationController
    before_action :get_order_product, only: [:new, :create]

    def new
    end

    def create
        @order_params = params.permit(:email, :code, :email_authentication_id, :product_id)
        # Check Code
        @email_authentication_request = EmailAuthenticationRequest.where(id: @order_params[:email_authentication_id]).first
        if not @email_authentication_request
            render :json => {
                :message => "이메일이 아직 발송되지 않았습니다"
            }, status: 404
            return
        elsif @email_authentication_request.code != @order_params[:code]
            render :json => {
                :message => "인증 번호가 일치하지 않습니다"
            }, status: 403
            return
        elsif @email_authentication_request.used
            render :json => {
                :message => "이미 사용된 인증 번호입니다"
            }, status: 410
            return
        end

        # Create Order
        @order = Order.new
        @order.product = @product
        @order.uuid = SecureRandom.uuid
        @order.email = @order_params[:email]
        @order.name = @product.name + " 주문"
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
end
