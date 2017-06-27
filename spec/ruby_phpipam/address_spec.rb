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

  context "method search" do
    it 'returns nil if no address exists in given subnet', :vcr do
      address = RubyPhpipam::Address.search(ip:"1.1.1.1", subnetId:12)
      expect(address).to be_nil
    end

    it 'returns address by IP from given subnet', :vcr do
      address = RubyPhpipam::Address.search(ip:"1.1.1.9", subnetId:12)
      expect(address).to be_an_instance_of(RubyPhpipam::Address)
      expect(address.ip).to eq "1.1.1.9"
    end

    it 'returns array of addresses from search by IP', :vcr do
      addresses = RubyPhpipam::Address.search(ip:"1.1.1.9")
      addresses.each do |address|
        expect(address).to be_an_instance_of(RubyPhpipam::Address)
        expect(address.ip).to eq "1.1.1.9"
      end
    end

    it 'returns array of addresses from search by hostname', :vcr do
      addresses = RubyPhpipam::Address.search(hostname:"server2.cust1.local")
      addresses.each do |address|
        expect(address).to be_an_instance_of(RubyPhpipam::Address)
        expect(address.hostname).to eq "server2.cust1.local"
      end
    end
  end
end