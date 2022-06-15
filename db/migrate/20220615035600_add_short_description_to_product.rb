class AddShortDescriptionToProduct < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :short_description, :string
  end
end
