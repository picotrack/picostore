class AddUsedToEmailAuthenticationRequest < ActiveRecord::Migration[6.1]
  def change
    add_column :email_authentication_requests, :used, :boolean
  end
end
