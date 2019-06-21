class Admin::SessionsController < ApplicationController
  before_action :require_login, only: [:destroy]
  def new
  end
  # ログイン後の処理　
  # Sorceryのログインメソッドlogin()⇨emailとパスワードの検証を行う。
  def create
    @user = login(params[:email],params[:password])
      if @user
        redirect_to admin_home_path
      else
        render :new
      end
  end

  def destroy
    logout
    redirect_to root_path
  end

  private

  def not_authenticated
    redirect_to root_path
  end

end
