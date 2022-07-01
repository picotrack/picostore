class Api::PaymentController < ApplicationController
  def success
    render :json => params
  end

  def failure
    render :json => params
  end
end
