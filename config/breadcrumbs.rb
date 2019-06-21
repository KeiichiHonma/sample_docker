crumb :root do
  link "TOP", root_path
end
crumb :articles do
  link "COLUMN", articles_path()
  parent :root
end

crumb :article do |article|
  link "@#{article.title}", articles_path(article)
  parent :articles
end
