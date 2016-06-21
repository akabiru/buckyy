source 'https://rubygems.org'

gem 'rails', '4.2.6'
gem 'rails-api'
gem 'pg'
gem 'figaro'
gem 'puma'
gem 'active_model_serializers', '~> 0.10.0.rc2'

group :development do
  gem 'spring'
  gem 'rubocop', '~> 0.40.0', require: false
end

group :development, :test do
  gem 'rspec-rails', '~> 3.4'
  gem 'pry-rails'
  gem 'faker'
  gem 'guard-rspec', require: false
end

group :test do
  gem "factory_girl_rails"
  gem 'shoulda-matchers', '~> 3.1'
  gem 'database_cleaner'
  gem 'coveralls', require: false
end
