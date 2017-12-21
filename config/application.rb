# frozen_string_literal: true

require_relative 'boot'

require 'rails'
require 'active_model/railtie'
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
require 'sprockets/railtie'

Bundler.require(*Rails.groups)

module ForumApi
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1
    
    config.time_zone = 'UTC'

    config.autoload_paths += %W[#{config.root}/app/repositories
                                #{config.root}/app/services
                                #{config.root}/app/responders
                                #{config.root}/app/formatters]

    config.api_only = true
  end
end
