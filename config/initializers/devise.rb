Devise.setup do |config|
  # Add a default scope to devise, to prevent it from checking
  # whether other devise enabled models are signed into a session or not
  config.default_scope = :spree_user
  # more details here https://github.com/spree/spree_auth_devise
  # Required so users don't lose their carts when they need to confirm.
  config.allow_unconfirmed_access_for = 1.days

  # Fixes the bug where Confirmation errors result in a broken page.
  config.router_name = :spree

  # Add any other devise configurations here, as they will override the defaults provided by spree_auth_devise.

  # ==> Mailer Configuration
  # Configure the e-mail address which will be shown in DeviseMailer.
  config.mailer_sender = 'ofn@kandu.co.za'

  # Configure the class responsible to send e-mails.
  config.mailer = 'Spree::UserMailer'
  #config.mailer = 'EnterpriseMailer'
end
