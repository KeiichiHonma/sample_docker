class Admin::NewsController < ApplicationController
  before_action :require_login
  before_action :set_news, only: [:show, :edit, :update, :destroy]
  # before_action :require_login・・・ログインしているユーザーのみがアクセス可能。
  # current_user・・・現在ログインしているユーザーの情報を取得
  def index
    @news = News.all.order("news_created_at desc").page(params[:page]).per(10)
  end

  def show
  end

  def new
    @news = News.new
  end

  def create
    @news = News.new(news_params)

    if @news.save
      redirect_to admin_news_path(@news), notice: t("news_was_successfully_created")
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @news.update(news_params)
      redirect_to admin_news_path(@news), notice: t("news_was_successfully_updated")
    else
      render :edit
    end
  end

  def destroy
    @news.destroy
    redirect_to admin_news_index_url, notice: t("news_was_successfully_deleted")
  end

  private

  def news_params
    params.require(:news).permit(
        :title,
        :news_created_at,
        :description,
        )
  end

  def set_news
    @news = News.find(params[:id])
  end

end
