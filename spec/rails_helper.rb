require 'spec_helper'
# https://medium.com/ruby-on-rails/patterns-for-successful-rails-engines-a7dae3db6921

ENGINE_ROOT = File.join(File.dirname(__FILE__), '../')

# Load environment.rb from the dummy app.
require File.expand_path('../dummy/config/environment.rb', __FILE__)

abort('The Rails environment is not running in test mode!') unless Rails.env.test?
require 'rspec/rails'
require 'shoulda/matchers'
require 'database_cleaner'

# Load RSpec helpers.
Dir[File.join(ENGINE_ROOT, 'spec/support/**/*.rb')].each { |f| require f }

# Load migrations from the dummy app.
ActiveRecord::Migrator.migrations_paths = File.join(ENGINE_ROOT, 'spec/dummy/db/migrate')
ActiveRecord::Migration.maintain_test_schema!

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    # Choose a test framework:
    with.test_framework :rspec

    # Choose one or more libraries:
    with.library :active_record
    with.library :active_model
  end
end

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.include FactoryBot::Syntax::Methods
  config.include(Shoulda::Matchers::ActiveModel, type: :model)
  config.include(Shoulda::Matchers::ActiveRecord, type: :model)

  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.append_after(:each) do
    DatabaseCleaner.clean
  end
end
