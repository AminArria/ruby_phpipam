require "spec_helper"

RSpec.describe RubyPhpipam::Authentication do

  it 'authenticates successfully', :vcr do
    load_configuration
    expect {
      RubyPhpipam::Authentication.new
    }.not_to raise_error
  end

  it 'raises an error when credentials are bad', :vcr do
    load_configuration(username: "bad_username")
    expect {
      RubyPhpipam::Authentication.new
    }.to raise_error(RubyPhpipam::AuthenticationFailed)
  end
end
