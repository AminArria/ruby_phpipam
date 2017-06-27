require "spec_helper"

RSpec.describe RubyPhpipam::Address do
  before :each do
    VCR.use_cassette("RubyPhpipam_Address/authenticate") do
      load_configuration
      RubyPhpipam.authenticate
    end
  end

  it "raises an error when address doesn't exist", :vcr do
    expect {
      RubyPhpipam::Address.get(999)
    }.to raise_error(RubyPhpipam::RequestFailed)
  end

  it 'gets a address by id', :vcr do
    address = RubyPhpipam::Address.get(9)
    expect(address.id).to eq 9
  end
end