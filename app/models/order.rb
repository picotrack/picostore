class Order < ApplicationRecord
    has_one :payment
    has_one :email_authentication_request, optional: true

    belongs_to :product
end
