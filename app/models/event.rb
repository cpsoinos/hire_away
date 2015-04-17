class Event < ActiveRecord::Base
  belongs_to :venue
  has_many :calls
  has_many :positions, through: :calls
  has_many :offers
  has_many :users, through: :offers

  validates :name, presence: true
  validates :venue, presence: true

  def self.add_to_calendar(new_event)
    RiCal.Calendar do |cal|
      cal.event do |event|
        event.description = name
        event.dtstart =  start_time
        event.dtend = end_time
        event.location = venue.name
        # event.add_attendee "john.glenn@nasa.gov"
        # event.alarm do
        #   description "Segment 51"
        # end
      end
    end
  end
end
