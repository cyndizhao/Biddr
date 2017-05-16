class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  before_action :get_user, only:[:show]
  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Thank you for signing in"
      redirect_to root_path
    else
      flash[:alert] = "Invalid user info!"
      render :new
    end
  end

  def show
  end
  private
    def get_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit([:first_name, :last_name, :email, :password, :password_confirmation])
    end
end
