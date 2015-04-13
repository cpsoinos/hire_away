class CreateCalls < ActiveRecord::Migration
  def change
    create_table :calls do |t|
      t.integer :event_id, null: false
      t.integer :position_id, null: false
      t.integer :user_id
    end

    remove_column :positions, :event_id, :integer
    remove_column :positions, :user_id, :integer
  end
end
