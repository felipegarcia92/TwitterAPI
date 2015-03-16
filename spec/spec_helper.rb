require 'spork'

Spork.each_run do
 # Loading more in this block will cause your tests to run faster. However,
 # if you change any configuration or code from libraries loaded here, you'll
 # need to restart spork for it take effect.

 ENV['RAILS_ENV'] = 'test'

 require File.expand_path('../../config/environment', __FILE__)
 require 'rspec/rails'
 require 'simplecov'

 SimpleCov.start do
   add_filter '/config/'
   add_filter '/spec/'
 end

 FactoryGirl.factories.clear
 FactoryGirl.reload

 # This file is copied to spec/ when you run 'rails generate rspec:install'
 ENV['SKIP_RAILS_ADMIN_INITIALIZER'] = 'false'

 # Change rails logger level to reduce IO during tests
 Rails.logger.level = 4

 RSpec.configure do |config|
   config.use_transactional_fixtures = false
   config.infer_base_class_for_anonymous_controllers = false
   config.order = 'random'

   # config.include Devise::TestHelpers, type: :controller

   config.before(:suite) do
     DatabaseCleaner.strategy = :transaction
     DatabaseCleaner.clean_with(:truncation)
     DatabaseCleaner.start
     DatabaseCleaner.clean
   end

   config.before(:each) do
     DatabaseCleaner.clean_with(:truncation)
   end

   config.after(:each) do
     DatabaseCleaner.clean_with(:truncation)
   end

   config.after(:suite) do
     DatabaseCleaner.clean_with(:truncation)
   end

 end
end
