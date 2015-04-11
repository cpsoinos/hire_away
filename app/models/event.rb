class Event < ActiveRecord::Base
  belongs_to :venue
  has_many :positions

  validates :name, presence: true
  validates :venue, presence: true
end
