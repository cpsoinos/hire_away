class VenuesController < ApplicationController

  def index
    @venues = Venue.order("name ASC").page(params[:page])
  end

end
