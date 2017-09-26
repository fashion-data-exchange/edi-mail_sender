require "bundler/setup"
require "fde/mail_sender"

require 'pry'
require 'dotenv'

Dotenv.load('.test.env')

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.profile_examples = 10
  config.order = :random
  Kernel.srand config.seed
end


FDE::MailSender.configure do |config|
  config.address = ENV.fetch('SMTP_MAIL_ADDRESS')
  config.port = ENV.fetch('SMTP_MAIL_PORT')
  config.domain = ENV.fetch('SMTP_MAIL_DOMAIN')
  config.user_name = ENV.fetch('SMTP_MAIL_USER_NAME')
  config.password = ENV.fetch('SMTP_MAIL_PASSWORD')
  config.authentication = ENV.fetch('SMTP_MAIL_AUTHENTICATION')
  config.enable_starttls_auto = ENV.fetch('SMTP_MAIL_ENABLE_STARTTLS_AUTO')

  config.from = ENV.fetch('SMTP_MAIL_FROM', 'edi@faden.io')
end
