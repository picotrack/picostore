class CreateProductTiers < ActiveRecord::Migration[6.1]
  def change
    create_table :product_tiers do |t|
      t.integer :product_id
      t.string :name
      t.text :description
      t.integer :price

      t.timestamps
    end
  end
end
