class Admin::ArticlesController < ApplicationController
  before_action :require_login
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  # before_action :require_login・・・ログインしているユーザーのみがアクセス可能。
  # current_user・・・現在ログインしているユーザーの情報を取得

  def index
    @articles = Article.all.order("id desc").page(params[:page]).per(10)
  end

  def show
  end

  def new
    @article = Article.new
  end
  def create
    @article = Article.new(article_params)
    if @article.save
      root_url = root_url(protocol: 'https')
      Nagareboshi::Sender.publish("#{root_url}articles/#{@article.id}")
      redirect_to admin_article_path(@article), notice: t("article_was_successfully_created")
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @article.update(article_params)
      root_url = root_url(protocol: 'https')
      Nagareboshi::Sender.publish("#{root_url}articles/#{@article.id}")
      redirect_to admin_article_path(@article), notice: t("article_was_successfully_updated")
    else
      render :edit
    end
  end

  def destroy
    @article.destroy
    redirect_to admin_articles_url, notice: t("article_was_successfully_deleted")
  end

  private
  def article_params
    params.require(:article).permit(
        :title,
        :description,
        )
  end

  def set_article
    @article = Article.find(params[:id])
  end

end
