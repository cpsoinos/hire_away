class AddStartAndEndTimesToCalls < ActiveRecord::Migration
  def change
    add_column :calls, :start_time, :datetime, null: false
    add_column :calls, :end_time, :datetime, null: false
  end
end
