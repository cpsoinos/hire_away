class Venue < ActiveRecord::Base
  has_many :users

  validates :name, presence: true
  validates :city, presence: true
  validates :state, presence: true
end
