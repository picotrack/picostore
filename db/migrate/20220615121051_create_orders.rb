class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer :product_id
      t.string :uuid, index: {unique: true}
      
      t.string :email
      t.string :name
      t.string :customer_name

      t.integer :price

      t.timestamps
    end
  end
end
