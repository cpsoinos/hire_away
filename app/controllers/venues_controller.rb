class VenuesController < ApplicationController

  def index
    @venues = Venue.order("name ASC").page(params[:page])
  end

  def show
    @venue = Venue.find(params[:id])
    @optionals = [
      @venue.zip_code,
      @venue.contact_phone,
      @venue.contact_phone,
      @venue.contact_email
    ]
  end

  def new
    @venue = Venue.new
  end

  def create
    @venue = Venue.create(venue_params)
    if @venue.save
      flash[:notice] = "Venue created!"
      redirect_to venue_path(@venue)
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
