class CreatePayments < ActiveRecord::Migration[6.1]
  def change
    create_table :payments do |t|
      t.integer :order_id
      t.string :uuid, index: {unique: true}

      t.string :email
      t.integer :amount
      t.boolean :complete

      t.timestamps
    end
  end
end
