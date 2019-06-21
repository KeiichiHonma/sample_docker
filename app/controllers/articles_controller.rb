class ArticlesController < ApplicationController
  include LatestContents
  before_action -> { latest_news(2) }

  def index
    @latest_articles = Article.where("id >= '514'").limit(12).order("id DESC")
  end

  def show
    @article = Article.find(params[:id])
  end

end
