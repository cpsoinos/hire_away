class AddTimestampsToVenues < ActiveRecord::Migration
  def change
    add_column :venues, :created_at, :datetime
    add_column :venues, :updated_at, :datetime
  end
end
