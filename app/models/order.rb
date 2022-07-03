class Order < ApplicationRecord
    has_one :payment
    has_one :email_authentication_request, required: false

    belongs_to :product
end
