class VenuesController < ApplicationController
  before_action :authorize_admin!

  def index
    @venues = Venue.order("name ASC").page(params[:page])
    @venue = Venue.new
  end

  def show
    @venue = Venue.find(params[:id])
    @optionals = [
      @venue.contact_phone,
      @venue.contact_phone,
      @venue.contact_email
    ]
    @google_maps_url = %Q{
      https://www.google.com/maps/embed/v1/place?key=
      #{ENV["GOOGLE_MAPS_API_KEY"]}&q=#{@venue.parse_for_google_maps}
    }
  end

  def new
    @venue = Venue.new
  end

  def create
    @venue = Venue.create(venue_params)
    if @venue.save
      respond_to do |format|
        format.html do
          flash[:notice] = "Venue created!"
          redirect_to venue_path(@venue)
        end
        format.js do
          render :create
        end
      end
    else
      render :new
    end
  end

  def edit
    @venue = Venue.find(params[:id])
  end

  def update
    @venue = Venue.find(params[:id])
    if @venue.update(venue_params)
      flash[:notice] = "Venue updated!"
      redirect_to venue_path(@venue)
    else
      render :edit
    end
  end

  def destroy
    @venue = Venue.find(params[:id])
    @venue.destroy
    flash[:notice] = "Venue deleted!"
    redirect_to venues_path
  end

  private

  def venue_params
    params.require(:venue).permit(
      :name, :street_address, :street_address_2, :city, :state,
      :zip_code, :contact_name, :contact_phone, :contact_email
    )
  end
end
