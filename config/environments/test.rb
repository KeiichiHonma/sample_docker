Rails.application.configure do
  config.cache_classes = false

  config.eager_load = false

  config.public_file_server.enabled = true
  config.public_file_server.headers = {
    "Cache-Control" => "public, max-age=#{1.hour.to_i}"
  }

  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = false

  config.action_dispatch.show_exceptions = false

  config.action_controller.allow_forgery_protection = false

  config.active_storage.service = :test

  config.action_mailer.perform_caching = false

  config.action_mailer.delivery_method = :test

  config.active_support.deprecation = :stderr

  config.action_mailer.delivery_method = :smtp
  ActionMailer::Base.smtp_settings = {
      user_name:             ENV["SENDGRID_USERNAME"],
      password:              ENV["SENDGRID_PASSWORD"],
      domain:                "sleepdays.jp",
      address:               "smtp.sendgrid.net",
      port:                  2525,
      authentication:        :plain,
      enable_starttls_auto:  true
  }
  config.url = "http://testing.sleepdays.jp/"
end
