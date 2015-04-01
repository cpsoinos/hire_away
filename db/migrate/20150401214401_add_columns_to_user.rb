class AddColumnsToUser < ActiveRecord::Migration
  def change
    add_column :users, :admin, :boolean, default: false
    add_column :users, :first_name, :string, null: false
    add_column :users, :last_name, :string, null: false
    add_column :users, :street_address, :string, null: false
    add_column :users, :street_address_2, :string
    add_column :users, :city, :string, null: false
    add_column :users, :state, :string, null: false
    add_column :users, :zip_code, :string, null: false
    add_column :users, :phone, :string, null: false
  end
end
