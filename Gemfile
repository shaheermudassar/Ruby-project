# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0'
gem 'active_storage_validations'
gem 'bootstrap', '~> 5.2', '>= 5.2.1'
gem 'cloudinary'
gem 'coffee-rails', '~> 4.2'
gem 'devise'
gem 'figaro'
gem 'font-awesome-rails'
gem 'image_processing'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'pundit'
gem 'rails', '~> 5.2.8', '>= 5.2.8.1'
gem 'rails_admin'
gem 'sass-rails', '~> 5.0'
gem 'tinymce-rails'
gem 'turbolinks', '~> 5'

gem 'bootsnap', '>= 1.1.0', require: false

group :test do
  gem 'pundit-matchers'
  gem 'shoulda-matchers', '~> 5.0'
  gem 'simplecov', require: false
end

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'faker', git: 'https://github.com/faker-ruby/faker.git', branch: 'main'
  gem 'rails-controller-testing'
  gem 'rspec-rails'
  gem 'rubocop'
  gem 'rubocop-minitest'
  gem 'rubocop-performance'
  gem 'rubocop-rails'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

gem 'terser', '~> 1.1'
