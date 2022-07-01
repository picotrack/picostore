class CreateEmailAuthenticationRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :email_authentication_requests do |t|
      t.string :code
      t.datetime :expires_at
      t.boolean :used
      t.integer :order_id

      t.timestamps
    end
  end
end
