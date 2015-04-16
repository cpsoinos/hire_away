class CreateAvailability < ActiveRecord::Migration
  def change
    create_table :availabilities do |t|
      t.integer :offer_id, null: false
      t.integer :call_id, null: false
      t.boolean :available
    end

    remove_column :offers, :call_id, :integer
    add_column :calls, :availabity_id, :integer
    add_column :offers, :availabity_id, :integer
  end
end
