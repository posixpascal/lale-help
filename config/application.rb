require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(*Rails.groups)

module LaleHelp
  class Application < Rails::Application
    LaleHelp::Application.config.assets.version = '1.0'

    config.assets.precompile += %w( .svg .eot .woff .woff2 .ttf )

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{yml}').to_s]
    # config.i18n.default_locale = :de

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true
    
    unless Rails.env.test?
      config.action_mailer.smtp_settings = {
        address: ENV.fetch("SMTP_ADDRESS"),
        authentication: :plain,
        domain: ENV.fetch("SMTP_DOMAIN"),
        enable_starttls_auto: true,
        password: ENV.fetch("SMTP_PASSWORD"),
        port: "587",
        user_name: ENV.fetch("SMTP_USERNAME")
      }
    end
    config.action_mailer.default_url_options = { host: ENV["SMTP_DOMAIN"] }
  end
end
