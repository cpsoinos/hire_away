class PositionsController < ApplicationController

  def index
    @positions = Position.all
  end

  def show
    @position = Position.find(params[:id])
  end

  def new
    @position = Position.new
  end

  def create
    @position = Position.new(position_params)
    if @position.save
      respond_to do |format|
        format.html do
          flash[:notice] = "Position created!"
          redirect_to :back
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
    @position = Position.find(params[:id])
  end

  def update
    @position = Position.find(params[:id])
    if @position.update(position_params)
      flash[:notice] = "Position updated!"
      redirect_to :back
    else
      render :edit
    end
  end

  def destroy
    @position = Position.find(params[:id])
    @position.destroy
    flash[:notice] = "Position deleted!"
    redirect_to events_path
  end

  private

  def position_params
    params.require(:position).permit(
      :name, :pay_rate_cents
    )
  end

end
