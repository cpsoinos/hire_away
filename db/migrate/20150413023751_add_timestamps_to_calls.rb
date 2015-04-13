class AddTimestampsToCalls < ActiveRecord::Migration
  def change
    add_column :calls, :created_at, :datetime
    add_column :calls, :updated_at, :datetime
  end
end
