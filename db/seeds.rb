require_relative "../spec/support/factory_girl.rb"

# 5.times do
#   FactoryGirl.create(:venue)
# end
#
# 5.times do
#   FactoryGirl.create(:event)
# end
#
10.times do
  FactoryGirl.create(:user)
end

Venue.create(
  name: "Castle at Park Plaza",
  street_address: "64 Arlington St.",
  city: "Boston",
  state: "MA",
  zip_code: "02116"
)

Venue.create(
  name: "Cyclorama",
  street_address: "539 Tremont St.",
  city: "Boston",
  state: "MA",
  zip_code: "02116"
)

Venue.create(
  name: "Cutler Magestic Theatre",
  street_address: "219 Tremont St.",
  city: "Boston",
  state: "MA",
  zip_code: "02116"
)

Venue.create(
  name: "Paramount",
  street_address: "559 Washington St.",
  city: "Boston",
  state: "MA",
  zip_code: "02116"
)

Venue.create(
  name: "Huntington Theater",
  street_address: "264 Huntington Ave.",
  city: "Boston",
  state: "MA",
  zip_code: "02115"
)

Venue.create(
  name: "American Repertory Theater (A.R.T.)",
  street_address: "64 Brattle St.",
  city: "Cambridge",
  state: "MA",
  zip_code: "02138"
)

Position.create(
  name: "Technician",
  pay_rate_cents: "2500"
)

Position.create(
  name: "Project Manager",
  pay_rate_cents: "3000"
)
