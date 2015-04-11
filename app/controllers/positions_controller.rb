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
      flash[:notice] = "Position created!"
      redirect_to :back
    else
      render :new
    end
  end

  def edit
    @position = Position.find(params[:id])
  end

  def update
    @position = Position.find(params[:id])
    if position.update(position_params)
      flash[:notice] = "Position updated!"
      redirect_to :back
    else
      render :edit
    end
  end

  private

  def position_params
    params.require(:position).permit(
      :name, :pay_rate_cents
    )
  end

end