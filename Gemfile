source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.2'

# Use sqlite3 as the database for Active Record
gem 'sqlite3'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.1.2', :require => 'bcrypt'

# Use RSpec for testing
# Run `rake spec` to run tests once
# Documentation on matchers: https://www.relishapp.com/rspec/rspec-expectations/v/3-0/docs/built-in-matchers
gem "rspec-rails", :group => [:test, :development]

group :test do
  # Use factories instead of fixtures
  # NOTE: this might need to be in the development group as well to generate factories instead of fixtures
  gem "factory_girl_rails"

  # For acceptance/integration tests
  gem "capybara"

  # Auto-run tests
  gem "guard-rspec"

  # If running guard on Mac OS X
  # gem "rb-fsevent"
end

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
