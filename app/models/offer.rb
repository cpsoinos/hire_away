class Offer < ActiveRecord::Base
  belongs_to :event
  belongs_to :call
  belongs_to :user

  validates :event, presence: true, uniqueness: true
  validates :call, presence: true
  validates :user, presence: true
end
