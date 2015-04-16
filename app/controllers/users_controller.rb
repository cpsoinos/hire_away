class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_user, except: [:create, :new, :update, :index]

  def index
    authorize_admin
    @users = User.order("last_name ASC").page(params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "User updated!"
      redirect_to users_path
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = "User deleted!"
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :role, :avatar, :name, :remove_avatar)
  end
end
