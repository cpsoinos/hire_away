class Position < ActiveRecord::Base
  belongs_to :event
  belongs_to :user

  validates :name, presence: true
  validates :pay_rate_cents, presence: true
end
