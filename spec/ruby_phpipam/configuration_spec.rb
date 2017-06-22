require "spec_helper"

RSpec.describe RubyPhpipam::Configuration do
  it 'sets the configuration variables' do
    RubyPhpipam.configure do |config|
      config.base_url = "url"
      config.username = "username"
      config.password = "password"
    end

    expect(RubyPhpipam.configuration.base_url).to eq "url"
    expect(RubyPhpipam.configuration.username).to eq "username"
    expect(RubyPhpipam.configuration.password).to eq "password"
  end
end
