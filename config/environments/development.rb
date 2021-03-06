Geoflux::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.default_url_options = { :host => "localhost:3000" }
  # to use mailcatcher:
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = { :address => "localhost", :port => 1025 }

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  config.after_initialize do
    Rails.logger.level = Logger::INFO
    Rails::Rack::Logger.class_eval do
      def call_with_quiet_assets(env)
        previous_level = Rails.logger.level
        Rails.logger.level = Logger::ERROR if env['PATH_INFO'].index("/assets/") == 0
        call_without_quiet_assets(env).tap do
          Rails.logger.level = previous_level
        end
      end
      alias_method_chain :call, :quiet_assets
    end
  end

end
