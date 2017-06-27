require "spec_helper"

RSpec.describe RubyPhpipam::Subnet do
  before :each do
    load_configuration
    RubyPhpipam.authenticate
  end

  it "raises an error when subnet doesn't exist", :vcr do
    expect {
      RubyPhpipam::Subnet.get(999)
    }.to raise_error(RubyPhpipam::RequestFailed)
  end

  it 'gets a subnet by id', :vcr do
    subnet = RubyPhpipam::Subnet.get(9)
    expect(subnet.id).to eq 9
  end

  it 'gets all addresses belonging to a subnet', :vcr do
    subnet = RubyPhpipam::Subnet.get('9')
    addresses = subnet.addresses

    addresses.each do |address|
      expect(address.subnetId).to eq subnet.id
    end
  end

  it 'raises an error when search string is not in CIDR format' do
    expect {
      RubyPhpipam::Subnet.search("1.2.3.0 / 24")
    }.to raise_error(RubyPhpipam::WrongFormatSearch)
  end

  it 'returns nil when no subnet matches cidr', :vcr do
    subnet = RubyPhpipam::Subnet.search("1.2.3.0/24")
    expect(subnet).to be_nil
  end

  it 'returns subnet that matches cidr', :vcr do
    subnet = RubyPhpipam::Subnet.search("1.1.1.0/24")
    expect(subnet).not_to be_nil
    expect(subnet.subnet).to eq "1.1.1.0"
    expect(subnet.mask).to eq 24
  end

  it 'returns subnet with usage instace variables set', :vcr do
    subnet = RubyPhpipam::Subnet.get(9)
    expect(subnet.used).to be_nil
    expect(subnet.maxhosts).to be_nil
    expect(subnet.freehosts).to be_nil
    expect(subnet.freehosts_percent).to be_nil

    subnet.usage!
    expect(subnet.used).not_to be_nil
    expect(subnet.maxhosts).not_to be_nil
    expect(subnet.freehosts).not_to be_nil
    expect(subnet.freehosts_percent).not_to be_nil
  end
end