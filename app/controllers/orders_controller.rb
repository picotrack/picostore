class OrdersController < ApplicationController
    before_action :get_product, only: [:new]

    def new
        # @product_tier_id = ProductTier.find(params[:product_tier_id])
    end

    private

    def get_product
        @product = Product.find(params[:product_id])
    end
end
