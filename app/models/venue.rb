class Venue < ActiveRecord::Base
  has_many :events

  validates :name, presence: true
  validates :city, presence: true
  validates :state, presence: true

  def location
    "#{street_address}, #{city}, #{state}"
  end

  def parse_for_google_maps
    @google_map_params = [street_address, city, state].join(" ")
    @google_map_params.gsub!(" ", "+")
  end

end
