# frozen_string_literal: true

# name: discourse-sentry
# about: Forward Discourse Rails/Sidekiq errors to a Sentry-compatible endpoint (e.g. GlitchTip).
# version: 0.1.0
# authors: ikaskey
# url: https://github.com/stayhomeairlines/discourse-sentry

gem 'sentry-ruby', '6.5.0'
gem 'sentry-rails', '6.5.0'
gem 'sentry-sidekiq', '6.5.0'

after_initialize do
  dsn = ENV['DISCOURSE_SENTRY_DSN']
  if dsn && !dsn.strip.empty?
    Sentry.init do |config|
      config.dsn = dsn
      config.environment = ENV['DISCOURSE_SENTRY_ENVIRONMENT'] || Rails.env
      config.release = Discourse::VERSION::STRING
      config.send_default_pii = false
      config.breadcrumbs_logger = [:active_support_logger]
    end
    Rails.logger.info "[discourse-sentry] initialized dsn=#{dsn[0, 40]}..."
  end
end
