# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.5'

gem 'rails', '~> 6.0.0'

gem 'bootsnap', '>= 1.4.2', require: false
gem 'pg', '~> 1.1.4'
gem 'puma', '~> 3.12.1'

group :development, :test do
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
end
