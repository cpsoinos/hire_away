class RemoveConstraintFromAvailabilities < ActiveRecord::Migration
  def change
    remove_column :availabilities, :offer_id, :integer, null: false
    add_column :availabilities, :offer_id, :integer
  end
end
