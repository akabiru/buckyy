source 'https://rubygems.org'

gem 'rails', '4.2.6'
gem 'rails-api'
gem 'pg'
gem 'figaro'
gem 'puma'

group :development do
  gem 'pry-rails'
  gem 'spring'
  gem 'rubocop', '~> 0.40.0', require: false
  gem 'guard-rspec', require: false
end

group :development, :test do
  gem 'rspec-rails', '~> 3.4'
end

group :test do
  gem "factory_girl_rails"
  gem 'shoulda-matchers', '~> 3.1'
  gem 'database_cleaner'
  gem 'coveralls', require: false
end
