# Blog App
Blog app is a social app for posting different types of Article. It consists of three type of users with role as admin, moderator and normal user.
Each user with particular role can do just assigned actions to him.
A normal User can create articles with images, comments with images, reply, like, suggestion and report a article/comment.
Moderator can publish or unpublish or delete articles created & reported by normal user.
Admin can see every activity and can create, edit and delete any article, comment, like, reply and suggestion.
# Getting Started
## Pre requisites
What Ruby version we need in this application
 - Ruby version : 2.7.6
 - Rails version : 5.2.8
 - Postgresql version : 15.0
## Gem Dependencies
gem 'bootstrap', '~> 5.2', '>= 5.2.1'
gem 'pg', '>= 0.18', '< 2.0'
gem 'active_storage_validations'
gem 'cloudinary'
gem 'devise'
gem 'figaro'
gem 'font-awesome-rails'
gem 'image_processing'
gem 'pundit'
gem 'rails_admin'
gem 'tinymce-rails'
gem 'terser', '~> 1.1'
gem 'rubocop'
gem 'rubocop-minitest' # or gem 'rubocop-rspec' depending on your test suite
gem 'rubocop-performance'
gem 'rubocop-rails'


## Configuration
Below is an example of how you can instruct your audience on installing and setting up your app. This template doesn't rely on any external dependencies or services.
1. Clone the repo.

2. after clone, you need to install all the dependencies.
    `bundle install`
3. Go to terminal and run the following command
    `rails s`
## Database creation
For the local development use the following commands for database creation
 `bundle install`
 `rails db:create`
 `rails db:migrate`
For deploying on the production use the following commands on Heroku CLI
 `heroku run rails db:create`
 `heroku run rails db:migrate`
