# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.5'

gem 'rails', '~> 6.0.0'

gem 'bootsnap', '>= 1.4.2', require: false
gem 'fast_jsonapi', '~> 1.5'
gem 'pg', '~> 1.1.4'
gem 'puma', '~> 3.12.4'

group :development, :test do
  gem 'factory_bot_rails', '~> 5.1.1'
  gem 'pry-rails', '~> 0.3.9'
  gem 'rspec-rails', '~> 4.0.0.beta3'
  gem 'rubocop-rails', '~> 2.3.2'
end

group :development do
  gem 'listen', '~> 3.1.5'
  gem 'spring', '~> 2.1.0'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'shoulda-matchers', '~> 4.1.2'
  gem 'simplecov', '~> 0.17.1', require: false
end
