class EmailAuthenticationRequest < ApplicationRecord
    belongs_to :order, optional: true
end
