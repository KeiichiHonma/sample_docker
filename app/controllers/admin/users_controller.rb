class Admin::UsersController < ApplicationController
   #before_action :require_login
  def new
    logger.debug "aaa"
    @user = User.new
    # redirect_to admin_home_path
  end

  def create
  @user = User.new(user_params)
    if @user.save
      auto_login(@user)
      redirect_to admin_home_path
    else
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
