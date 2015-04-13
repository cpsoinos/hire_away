class Event < ActiveRecord::Base
  belongs_to :venue
  has_many :calls
  has_many :positions, through: :calls

  validates :name, presence: true
  validates :venue, presence: true
end
