class NewsController < ApplicationController
  include LatestContents
  before_action -> { latest_news(10) }, only: [:index]

  def show
    @news = News.find(params[:id])
  end

  def index
  end

end
