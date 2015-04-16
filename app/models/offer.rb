class Offer < ActiveRecord::Base
  belongs_to :event
  belongs_to :user
  has_many :availabilities
  has_many :calls, through: :availabilities

  validates :event, presence: true
  validates :user, presence: true
end
