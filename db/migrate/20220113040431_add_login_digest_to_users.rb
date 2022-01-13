class AddLoginDigestToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :login_digest, :string
  end
end
