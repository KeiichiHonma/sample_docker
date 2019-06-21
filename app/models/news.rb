class News < ApplicationRecord
  validates :title,                     presence: true, length: { maximum: 255 }
  validates :description,               presence: true

  def previous
    News.where("news_created_at < ?", self.news_created_at).order("news_created_at DESC").first
  end
  def next
    News.where("news_created_at > ?", self.news_created_at).order("news_created_at ASC").first
  end
end
