require 'rails_helper'

RSpec.configure do |config|
  config.include AcceptanceHelper, type: :feature
  config.use_transactional_fixtures = false

  config.before(:suite) do
    %x[bundle exec rake assets:precompile]
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, js: true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end

Capybara.javascript_driver = :webkit