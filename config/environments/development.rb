Openfoodnetwork::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request.  This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false
  config.cache_store = :memory_store

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

  # Do not compress assets
  config.assets.compress = false

  # # Expands the lines which load the assets
  # config.assets.debug = true
  # # Don't fallback to assets pipeline if a precompiled asset is missed
  # config.assets.compile = true
  # # Generate digests for assets URLs
  # config.assets.digest = false

  ## uncomment to increase debug perfomance (if assets debugging are not required)
  config.assets.debug = false
  config.assets.compile = false
  config.assets.digest = true
  ## end increase debug perfomance (if assets debugging are not required)

  # Show emails using Letter Opener
  config.action_mailer.delivery_method = :letter_opener
  config.action_mailer.default_url_options = { host: "0.0.0.0:3000" }
end


# Load heroku vars from local file
heroku_env = File.join(Rails.root, 'config', 'heroku_env.rb')
load(heroku_env) if File.exists?(heroku_env)
