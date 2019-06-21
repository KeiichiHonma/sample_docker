class Article < ApplicationRecord
  after_save :post_pubsubhubbub
  validates :title,                     presence: true, length: { maximum: 255 }
  validates :description,               presence: true

  def previous
    Article.where("id < ?", self.id).order("id DESC").first
  end
  def next
    Article.where("id > ?", self.id).order("id ASC").first
  end

end

  private

  def post_pubsubhubbub
    Nagareboshi::Sender.publish("http://example.com/")
  end
