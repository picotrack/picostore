include ActionView::Helpers::NumberHelper

class Product < ApplicationRecord
  has_rich_text :description
  has_one_attached :image
  has_one_attached :thumbnail
  has_many_attached :files

  belongs_to :owner, :class_name => "User", :foreign_key => :owner_id


  def price_tag
    ltp = number_with_delimiter self.price
    return "#{ltp}원"
  end
end
