# frozen_string_literal: true

require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
abort('The Rails environment is running in production mode!') if Rails.env.production?

require 'api_matchers'
require 'database_cleaner'
require 'factory_bot_rails'
require 'rails-controller-testing'
require 'rspec/rails'
require 'shoulda-matchers'
require 'timecop'

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

Searchkick.disable_callbacks

APIMatchers.setup do |config|
  config.header_method = :headers
  config.header_content_type_key = 'Content-Type'
  config.response_body_method = :body
  config.http_status_method = :status
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

RSpec.configure do |config|
  %i[controller view request].each do |type|
    config.include ::Rails::Controller::Testing::TestProcess, type: type
    config.include ::Rails::Controller::Testing::TemplateAssertions, type: type
    config.include ::Rails::Controller::Testing::Integration, type: type
  end
  config.include RequestsHelper
  config.include APIMatchers::RSpecMatchers
  config.include Devise::Test::ControllerHelpers, type: :controller

  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end
