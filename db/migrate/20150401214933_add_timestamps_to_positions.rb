class AddTimestampsToPositions < ActiveRecord::Migration
  def change
    add_column :positions, :created_at, :datetime
    add_column :positions, :updated_at, :datetime
  end
end
