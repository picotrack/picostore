class DropProductTiers < ActiveRecord::Migration[6.1]
  def change
    drop_table :product_tiers
  end
end
