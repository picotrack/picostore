class OrdersController < ApplicationController
    before_action :get_product, only: [:ask_email, :payment]

    def ask_email; end
    def payment; end


    private

    def get_product
        @product = Product.find(params[:product_id])
    end
end
