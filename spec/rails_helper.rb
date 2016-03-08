if ENV['CODECLIMATE']
  require 'codeclimate-test-reporter'
  CodeClimate::TestReporter.start
end
require 'rubygems'

require 'mocha/api'

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
#require 'rspec/autorun'
require 'webmock/rspec'
require 'shoulda'
require 'sidekiq/testing'

Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}
Dir[Rails.root.join("spec/fabricators/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  config.fail_fast = ENV['RSPEC_FAIL_FAST'] == "1"
  config.mock_framework = :mocha
  config.order = 'random'

  config.infer_spec_type_from_file_location!

  config.profile_examples = 10

  config.expect_with :rspec do |c|
    c.include_chain_clauses_in_custom_matcher_descriptions = true
    c.syntax = :expect
  end

  config.filter_run :focus

  config.use_transactional_fixtures = false

  config.run_all_when_everything_filtered = true

  config.example_status_persistence_file_path = "spec/examples.txt"

  config.disable_monkey_patching!

  if config.files_to_run.one?
    config.default_formatter = 'doc'
  end

  Kernel.srand config.seed

  config.include Helpers
  config.include Devise::TestHelpers, type: :controller
  #config.include DeviseMapping, type: :controller

  config.before(:all) do
    WebMock.disable_net_connect! allow_localhost: true
  end

  config.after(:suite) do
    WebMock.disable_net_connect!
  end
end
