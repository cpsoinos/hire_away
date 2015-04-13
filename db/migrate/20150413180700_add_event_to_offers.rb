class AddEventToOffers < ActiveRecord::Migration
  def change
    add_column :offers, :event_id, :integer, null: false, unique: true
  end
end
