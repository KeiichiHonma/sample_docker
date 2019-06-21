# Set the host name for URL creation
require File.expand_path(File.dirname(__FILE__) + "/environment")
SitemapGenerator::Sitemap.default_host = Rails.application.config.url
SitemapGenerator::Sitemap.public_path = "#{Rails.root}/public/"
SitemapGenerator::Sitemap.sitemaps_path = "sitemaps/"

SitemapGenerator::Sitemap.create do
  add about_path
  add news_index_path
  News.all.each do |news|
    add news_path(news), priority: 1.0, lastmod: news.updated_at, changefreq: "daily"
  end
  add articles_path
  Article.all.each do |article|
    add article_path(article), priority: 1.0, lastmod: article.updated_at, changefreq: "daily"
  end
  add products_path
  add recovery_eye_pillow_path
  add recovery_multi_wear_path
  add recovery_room_aroma_mist_path
  add bathtime_drink_path
  add recovery_leg_fit_path
  add recovery_leggings_path
  add recovery_long_sleeve_tshirt_path
  add recovery_short_sleeve_tshirt_path
  add recovery_cloth_path
  add contacts_path
  add association_path
  add faq_path
  add shop_list_path
  add privacypolicy_path
end
