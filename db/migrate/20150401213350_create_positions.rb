class CreatePositions < ActiveRecord::Migration
  def change
    create_table :positions do |t|
      t.string :name, null:false
      t.integer :event_id
      t.integer :user_id
    end
  end
end
