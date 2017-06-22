require "spec_helper"

RSpec.describe Phpipam::Authentication do

  it 'authenticates successfully', :vcr do
    load_configuration
    expect {
      Phpipam::Authentication.new
    }.not_to raise_error
  end

  it 'raises an error when credentials are bad', :vcr do
    load_configuration(username: "bad_username")
    expect {
      Phpipam::Authentication.new
    }.to raise_error(Phpipam::AuthenticationFailed)
  end
end
