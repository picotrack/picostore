require "external/toss_payments"

class HomeController < ApplicationController
  def index
  end

  def test
    test1 = TossPayments.new
    render :json => test1.test1
  end
end
