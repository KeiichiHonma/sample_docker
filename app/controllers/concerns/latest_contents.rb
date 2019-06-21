module LatestContents
  extend ActiveSupport::Concern

  def latest_news(num)
    @latest_news = News.limit(num).order("news_created_at DESC, id DESC")
  end

end
