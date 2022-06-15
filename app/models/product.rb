include ActionView::Helpers::NumberHelper

class Product < ApplicationRecord
  has_rich_text :description
  has_one_attached :image

  has_many :product_tiers, :dependent => :destroy
  belongs_to :owner, :class_name => "User", :foreign_key => :owner_id

  def lowest_tier
    target = nil
    self.product_tiers.each do |product_tier|
      if target != nil then
        if target.price > product_tier.price then
          target = product_tier
        end
      else
        target = product_tier
      end
    end

    return target
  end

  def price_tag
    if self.product_tiers.length == 0 then
      return nil
    else
      ltp = number_with_delimiter lowest_tier.price, :delimiter => ","
      if self.product_tiers.length == 1 then
        return "#{ltp}원"
      else
        return "#{ltp}원 ~"
      end
    end
  end
end
