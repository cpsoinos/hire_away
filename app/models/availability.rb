class Availability < ActiveRecord::Base
  belongs_to :offer
  belongs_to :call
end
