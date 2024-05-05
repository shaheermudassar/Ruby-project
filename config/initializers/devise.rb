# frozen_string_literal: true

Devise.setup do |config|
  config.mailer_sender = 'atiyaali653@gmail.com'
  require 'devise/orm/active_record'
  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]
  config.skip_session_storage = [:http_auth]
  config.stretches = Rails.env.test? ? 1 : 12
  config.reconfirmable = true
  config.expire_all_remember_me_on_sign_out = true
  config.password_length = 6..128
  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/
  config.lock_strategy = :failed_attempts
  config.paranoid = false
  config.unlock_keys = [:time]
  config.unlock_strategy = :time
  config.maximum_attempts = 5
  config.unlock_in = 5.minutes
  config.last_attempt_warning = true
  config.reset_password_within = 6.hours
  config.sign_out_via = :delete
end
