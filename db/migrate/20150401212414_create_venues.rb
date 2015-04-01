class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.string :name, null: false, unique: true
      t.string :street_address
      t.string :street_address_2
      t.string :city, null: false
      t.string :state, null: false
      t.string :zip_code
      t.string :contact_name
      t.string :contact_phone
      t.string :contact_email
    end
  end
end
