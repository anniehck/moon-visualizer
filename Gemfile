source 'https://rubygems.org/'

gem 'rails', '5'
gem 'pg', '~> 0.15'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'jquery-rails'
gem 'devise'
gem 'httparty'
gem 'geocoder'
gem 'carrierwave'
gem 'fog'
gem 'fog-aws'

group :development, :test do
  gem 'capybara'
  gem 'factory_girl_rails'
  gem 'rspec-rails', '~> 3.0'
  gem 'pry-rails'
  gem 'shoulda'
  gem 'valid_attribute'
  gem 'listen'
  gem 'dotenv-rails'
end

group :test do
  gem 'launchy', require: false
  gem 'database_cleaner'
  gem 'coveralls', require: false
end

group :production do
  gem 'rails_12factor'
  gem 'puma'
end

ruby '2.3.1'
