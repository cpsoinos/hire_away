class ChangeAdminOnUsers < ActiveRecord::Migration
  def change
    remove_column :users, :admin, :boolean
    add_column :users, :role, :string, default: "member", null: false
  end
end
