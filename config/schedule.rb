require File.expand_path(File.dirname(__FILE__) + "/environment")

set :output, "#{Rails.root}/log/cron.log"

rails_env = ENV["RAILS_ENV"] || :development
set :environment, rails_env

every 1.day, at: "4:30 am" do
  command "cd /home/kusanagi/sleepdays/current && RAILS_ENV=" + rails_env.to_s + "  bundle exec rake -s sitemap:create"
end
