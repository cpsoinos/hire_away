class Offer < ActiveRecord::Base
  belongs_to :event
  belongs_to :call
  belongs_to :user

  validates :event, presence: true
  validates :user, presence: true
end
