class Admin::HomeController < ApplicationController
  before_action :require_login
  #　before_action :require_login・・・ログインしているユーザーのみがアクセス可能。
  # current_user・・・現在ログインしているユーザーの情報を取得
  def index
  end
end
