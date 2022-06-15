class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer :product_id
      t.integer :product_tier_id
      t.integer :payment_id
      t.string :email
      t.boolean :payment_complete

      t.timestamps
    end
  end
end
