class Product < ApplicationRecord
  has_rich_text :description
  has_one_attached :image

  has_many :product_tiers, :dependent => :destroy
  belongs_to :owner, :class_name => "User", :foreign_key => :owner_id
end
