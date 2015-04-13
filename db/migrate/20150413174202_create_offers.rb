class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.integer :call_id
      t.integer :user_id
      t.boolean :available
    end

    remove_column :calls, :user_id, :integer
  end
end
