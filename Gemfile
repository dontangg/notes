source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.2'

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
# Similar to pjax
#gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'

# For reading meta-data on audio files. Read more: http://robinst.github.io/taglib-ruby/
#gem 'taglib-ruby', '~> 0.6.0', :require => 'taglib'

# Use the Amazon SDK
gem 'aws-sdk', '~> 1.32.0'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.1.2', :require => 'bcrypt'

# RSpec and FactoryGirl are in development so that their generators can run
group :development, :test do
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3'

  # Use RSpec for testing
  # Run `rake spec` to run tests once
  # Documentation on matchers: https://www.relishapp.com/rspec/rspec-expectations/v/3-0/docs/built-in-matchers
  gem "rspec-rails", :group => [:test, :development]

  # Use factories instead of fixtures
  gem "factory_girl_rails"
end

group :test do
  # For acceptance/integration tests
  gem "capybara"

  # Auto-run tests
  gem "guard-rspec"

  # If running guard on Mac OS X
  # gem "rb-fsevent"
end

# Use unicorn as the app server
gem 'unicorn' unless RUBY_PLATFORM =~ /mingw32/i

group :development do
  # Use Capistrano for deployment
  gem 'capistrano-rails', '~> 1.1.1'

  gem 'capistrano-bundler'

  # Add Capistrano rbenv tasks
  #gem 'capistrano-rbenv', '~> 2.0'
end

group :production do
  # Use Postgres
  gem 'pg', '~> 0.17.0', group: :production

  # Use New Relic for monitoring
  gem 'newrelic_rpm'
end

# Use debugger
# gem 'debugger', group: [:development, :test]
