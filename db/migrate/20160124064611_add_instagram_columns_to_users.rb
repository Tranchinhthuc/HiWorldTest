class AddInstagramColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :provider, :string
    add_column :users, :access_token, :string
    add_column :users, :uid, :string
    add_column :users, :instagram_secret, :string
  end
end
