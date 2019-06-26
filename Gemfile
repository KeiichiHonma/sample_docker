source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }
ruby "2.5.1"
gem "rails", "~> 5.2.1"
gem "mysql2", ">= 0.4.4", "< 0.6.0"
gem "puma", "~> 3.11"
gem "sassc-rails"
gem "uglifier", ">= 1.3.0"
gem "coffee-rails", "~> 4.2"
gem "jbuilder", "~> 2.5"
gem "bootsnap", ">= 1.1.0", require: false
gem "dotenv-rails"
gem "pankuzu"
gem "sitemap_generator"
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem "capistrano", "~> 3.5"
gem "capistrano-rails"
gem "capistrano-bundler"
gem "whenever", require: false
gem "sorcery"
gem "kaminari", "~> 0.17.0"
gem "nagareboshi"
group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem "web-console", ">= 3.3.0"
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "letter_opener"
  gem "letter_opener_web"
  gem "rubocop"
end

group :test do
  gem "capybara", ">= 2.15"
  gem "selenium-webdriver"
  gem "chromedriver-helper"
end

group :production, :test do
  gem "newrelic_rpm"
end
