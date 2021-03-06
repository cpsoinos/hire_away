class Call < ActiveRecord::Base
  belongs_to :event
  belongs_to :position
  belongs_to :user
  has_many :availabilities
  has_many :offers, through: :availabilities

  validates :event, presence: true
  validates :position, presence: true
end
