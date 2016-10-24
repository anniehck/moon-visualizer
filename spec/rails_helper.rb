# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'

if Rails.env.test?
  CarrierWave.configure do |config|
    config.storage = :file
    config.enable_processing = false
  end
end

# Checks for pending migration and applies them before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = false

  config.before(:suite) do
   if config.use_transactional_fixtures?
     raise(<<-MSG)
       Delete line `config.use_transactional_fixtures = true` from rails_helper.rb
       (or set it to false) to prevent uncommitted transactions being used in
       JavaScript-dependent specs.
       During testing, the app-under-test that the browser driver connects to
       uses a different database connection to the database connection used by
       the spec. The app's database connection would not be able to access
       uncommitted transaction data setup over the spec's database connection.
     MSG
   end
   DatabaseCleaner.clean_with(:truncation)
 end

 config.before(:each) do
   DatabaseCleaner.strategy = :transaction
 end

 config.before(:each, type: :feature) do
   # :rack_test driver's Rack app under test shares database connection
   # with the specs, so continue to use transaction strategy for speed.
   driver_shares_db_connection_with_specs = Capybara.current_driver == :rack_test
   Capybara.javascript_driver = :webkit

   unless driver_shares_db_connection_with_specs
     # Driver is probably for an external browser with an app
     # under test that does *not* share a database connection with the
     # specs, so use truncation strategy.
     DatabaseCleaner.strategy = :truncation
   end
 end

 config.before(:each) do
   DatabaseCleaner.start
 end

 config.append_after(:each) do
   DatabaseCleaner.clean
 end

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!
end
require "capybara/rails"
require "valid_attribute"

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end
