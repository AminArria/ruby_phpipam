require "bundler/setup"

require "dotenv"
Dotenv.load

require "phpipam"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

# Helper methods
def load_configuration(base_url:ENV["base_url"], username:ENV["username"], password:ENV["password"])
  Phpipam.configure do |config|
    config.base_url = base_url
    config.username = username
    config.password = password
  end
end
