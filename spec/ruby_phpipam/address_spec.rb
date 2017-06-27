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

  context "self.first_free" do
    it 'returns nil if there is no free address in the subnet', :vcr do
      free_ip = RubyPhpipam::Address.first_free(12)
      expect(free_ip).to be_nil
    end

    it 'returns first free address of the subnet', :vcr do
      free_ip = RubyPhpipam::Address.first_free(4)
      expect(free_ip).to eq "10.10.2.1"
    end
  end

  context "self.get_by_tag" do
    it 'raises an error if tag ID does not exist', :vcr do
      expect {
        RubyPhpipam::Address.get_by_tag(948)
      }.to raise_error(RubyPhpipam::RequestFailed)
    end

    it 'returns an empty array if there is no address with that tag', :vcr do
      addresses = RubyPhpipam::Address.get_by_tag(5)
      expect(addresses.count).to eq 0
    end

    it 'returns all addresses with that tag', :vcr do
      addresses = RubyPhpipam::Address.get_by_tag(2)
      addresses.each do |address|
        expect(address).to be_an_instance_of(RubyPhpipam::Address)
        expect(address.tag).to eq 2
      end
    end
  end
end