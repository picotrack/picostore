class AddOwnerIdToProduct < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :owner_id, :integer
  end
end