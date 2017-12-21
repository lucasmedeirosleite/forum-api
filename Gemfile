# frozen_string_literal: true

source 'https://rubygems.org'

ruby '2.4.2'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'active_model_serializers'
gem 'caze'
gem 'devise'
gem 'devise-jwt'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.7'
gem 'rack-cors'
gem 'rails', '~> 5.1.4'
gem 'responders'
gem 'versionist'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'dotenv-rails'
  gem 'pry-byebug'
  gem 'rubocop'
end

group :development do
  gem 'letter_opener_web'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'api_matchers'
  gem 'coveralls'
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'rails-controller-testing'
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'timecop'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
