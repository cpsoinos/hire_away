class AddTimestampsToTimecards < ActiveRecord::Migration
  def change
    add_column :timecards, :created_at, :datetime
    add_column :timecards, :updated_at, :datetime
  end
end
