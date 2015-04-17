class Venue < ActiveRecord::Base
  has_many :events

  validates :name, presence: true
  validates :city, presence: true
  validates :state, presence: true

  def location
    "#{street_address}, #{city}, #{state}"
  end
end
