class Call < ActiveRecord::Base
  belongs_to :event
  belongs_to :user
  belongs_to :position

  validates :event, presence: true
  validates :position, presence: true
end
