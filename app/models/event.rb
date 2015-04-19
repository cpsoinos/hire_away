class Event < ActiveRecord::Base
  belongs_to :venue
  has_many :calls
  has_many :positions, through: :calls
  has_many :offers
  has_many :users, through: :offers

  validates :name, presence: true
  validates :venue, presence: true

  def google_datetime(time)
    time.to_datetime.rfc3339
  end

  def add_to_calendar(new_event, user)
    event = {
      'summary' => new_event.description,
      'location' => new_event.venue.location,
      'start' => {
        'dateTime' => google_datetime(new_event.start_time)
      },
      'end' => {
        'dateTime' => google_datetime(new_event.end_time)
      },
    }
    # binding.pry
            #Use the token from the data to request a list of calendars
    token = user.token
    client = Google::APIClient.new
    client.authorization.access_token = token
    service = client.discovered_api('calendar', 'v3')
    result = client.execute(
      :api_method => service.events.insert,
      :parameters => {'calendarId' => ENV["GOOGLE_CALENDAR_ID"]},
      :body => JSON.dump(event),
      :headers => {'Content-Type' => 'application/json'}
    )
    binding.pry
    print result.data.id
  end
end
