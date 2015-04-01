class Event < ActiveRecord::Base
  belongs_to :venue

  validates :name, presence: true
  validates :venue_id, presence: true
end
