source 'https://rubygems.org'

gem 'rails', '3.2.3'
gem 'pg'

gem 'httparty'

gem 'haml-rails'
gem 'jbuilder'

gem 'awesome_print'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'bourbon'

  gem 'coffee-rails', '~> 3.2.1'
  #gem 'yui-compressor'
  gem 'uglifier', '>= 1.0.3'
end

group :development do
  gem 'unicorn'
end

group :development, :test do
  gem 'sqlite3'
  gem 'pry'

  gem 'formatted_rails_logger'
  gem 'turn', require: false

  gem 'minitest', '>= 2.1.0'
  gem 'minitest-context'
  gem 'miniskirt', require: false

  gem 'mocha', require: false
  gem 'capybara', require: false
  gem 'capybara_minitest_spec'
  gem 'hpricot'
  gem 'ruby_parser', '~> 2.3.1'

  gem 'jasmine', '~> 1.1.0'
  gem 'evergreen', require: 'evergreen/rails'
end
