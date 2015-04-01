class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name, null: false
      t.string :description
      t.datetime :start_time, null: false
      t.datetime :end_time, null: false
      t.integer :venue_id, null: false
    end
  end
end
