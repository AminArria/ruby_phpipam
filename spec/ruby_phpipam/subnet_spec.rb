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
    subnet = RubyPhpipam::Subnet.get('4')
    addresses = subnet.addresses

    expect(addresses.count).to be >= 1
    addresses.each do |address|
      expect(address.subnetId).to eq subnet.id
    end
  end

  it 'returns an empty array when subnet has no addresses', :vcr do
    subnet = RubyPhpipam::Subnet.get('9')
    addresses = subnet.addresses
    expect(addresses.count).to eq 0
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

  it 'raises an error if subnet contains subnets', :vcr do
    subnet = RubyPhpipam::Subnet.get(9)
    expect {
      free_ip = subnet.first_free_ip
    }.to raise_error(RubyPhpipam::RequestFailed)
  end

  it 'returns nil if there is no free ip in the subnet', :vcr do
    subnet = RubyPhpipam::Subnet.get(12)
    free_ip = subnet.first_free_ip
    expect(free_ip).to be_nil
  end

  it 'returns first free ip of the subnet', :vcr do
    subnet = RubyPhpipam::Subnet.get(4)
    free_ip = subnet.first_free_ip
    expect(free_ip).to eq "10.10.2.1"
  end

  it 'returns an empty array when subnet has no slave subnets', :vcr do
    subnet = RubyPhpipam::Subnet.get('4')
    slaves = subnet.slaves
    expect(slaves.count).to eq 0
  end

  it 'gets all slave subnets belonging to a subnet', :vcr do
    subnet = RubyPhpipam::Subnet.get('9')
    slaves = subnet.slaves

    expect(slaves.count).to be >= 1
    slaves.each do |slave|
      expect(slave.masterSubnetId).to eq subnet.id
    end
  end

  it 'returns nil if no subnet with given mask is posible', :vcr do
    subnet = RubyPhpipam::Subnet.get('9')
    slave = subnet.first_subnet(subnet.mask-1)
    expect(slave).to be_nil
  end

  it 'returns the first available slave subnet in CIDR format', :vcr do
    subnet = RubyPhpipam::Subnet.get('9')
    slave = subnet.first_subnet(30)
    expect(RubyPhpipam::Helper.validate_cidr(slave)).to be true
  end

  it 'returns all slave subnets recursively'

  it 'returns an empty array when no slave subnets are available for given mask', :vcr do
    subnet = RubyPhpipam::Subnet.get('9')
    slaves = subnet.all_subnets 25
    expect(slaves.count).to eq 0
  end

  it 'gets all available slave subnets (CIDR) belonging to a subnet', :vcr do
    subnet = RubyPhpipam::Subnet.get('9')
    slaves = subnet.all_subnets(28)

    expect(slaves.count).to be >= 1
    slaves.each do |slave|
      expect(RubyPhpipam::Helper.validate_cidr(slave)).to be true
    end
  end
end