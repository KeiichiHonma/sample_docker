Rails.application.configure do
  config.cache_classes = false
  config.eager_load = false
  config.consider_all_requests_local = true
  if Rails.root.join("tmp", "caching-dev.txt").exist?
    config.action_controller.perform_caching = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      "Cache-Control" => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end
  config.active_storage.service = :local

  config.action_mailer.raise_delivery_errors = false

  config.action_mailer.perform_caching = false

  config.active_support.deprecation = :log

  config.active_record.migration_error = :page_load

  config.active_record.verbose_query_logs = true

  config.assets.debug = true

  config.assets.quiet = true

  config.file_watcher = ActiveSupport::FileUpdateChecker

  config.action_mailer.delivery_method = :letter_opener_web

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
  config.url = "http://development.sleepdays.jp/"
  config.web_console.whitelisted_ips = "192.168.33.1"
end
