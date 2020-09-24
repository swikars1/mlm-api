# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

gem 'active_model_serializers'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.4', '>= 5.2.4.3'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false
# for image uploads
gem 'carrierwave', '~> 2.0'
gem 'closure_tree'
gem 'devise'
gem 'devise-jwt', '~> 0.8.0'
# for heroku
gem 'figaro', '~> 1.2.0'
gem 'geocoder', '~> 1.6.3'
# for image
gem 'api-pagination'
gem 'faker', git: 'https://github.com/faker-ruby/faker.git', branch: 'master'
gem 'kaminari'
gem 'mini_magick', '~> 4.10.1'
# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'pry'
  gem 'pry-byebug'
  gem 'rspec-rails', '~> 3.7'
  gem 'rubocop-rails'
end

group :development do
  gem 'awesome_print', git: 'https://github.com/awesome-print/awesome_print.git', branch: 'master'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
