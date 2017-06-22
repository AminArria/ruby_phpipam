require "bundler/setup"

require 'webmock/rspec'
require 'vcr'
require "dotenv"
Dotenv.load

require "ruby_phpipam"

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

# Helper methods
def load_configuration(base_url:ENV["base_url"], username:ENV["username"], password:ENV["password"])
  RubyPhpipam.configure do |config|
    config.base_url = base_url
    config.username = username
    config.password = password
  end
end
