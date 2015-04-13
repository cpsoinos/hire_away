class Position < ActiveRecord::Base
  has_many :calls
  has_many :events, through: :calls

  validates :name, presence: true
  validates :pay_rate_cents, presence: true
end
