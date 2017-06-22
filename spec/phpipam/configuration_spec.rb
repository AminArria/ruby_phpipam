require "spec_helper"

RSpec.describe Phpipam::Configuration do
  it 'sets the configuration variables' do
    Phpipam.configure do |config|
      config.base_url = "url"
      config.username = "username"
      config.password = "password"
    end

    expect(Phpipam.configuration.base_url).to eq "url"
    expect(Phpipam.configuration.username).to eq "username"
    expect(Phpipam.configuration.password).to eq "password"
  end
end
