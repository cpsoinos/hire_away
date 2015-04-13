class Event < ActiveRecord::Base
  belongs_to :venue
  has_many :calls
  has_many :positions, through: :calls
  has_many :offers
  has_many :users, through: :offers

  validates :name, presence: true
  validates :venue, presence: true
end
