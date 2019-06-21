require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Sleepdays
  class Application < Rails::Application
    config.time_zone = "Tokyo"
    config.i18n.default_locale = :ja
    config.active_record.default_timezone = :local
    config.load_defaults 5.2
    config.generators do |g|
      g.assets false
    end
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
