class Call < ActiveRecord::Base
  belongs_to :event
  belongs_to :position
  has_many :offers
  has_many :users, through: :offers

  validates :event, presence: true
  validates :position, presence: true
end
