class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :name
      t.integer :price
      t.string :description
      t.integer :owner_id
      t.string :call_to_action

      t.timestamps
    end
  end
end