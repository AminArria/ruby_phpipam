require "spec_helper"

RSpec.describe RubyPhpipam::Vlan do
  before :each do
    VCR.use_cassette("RubyPhpipam_Vlan/authenticate") do
      Timecop.freeze(VCR.current_cassette.originally_recorded_at || Time.now)
      load_configuration
      RubyPhpipam.authenticate
    end
  end

  context "method self.get" do
    # it "raises an error when vlan doesn't exist", :vcr do
    #   expect {
    #     RubyPhpipam::Vlan.get(999)
    #   }.to raise_error(RubyPhpipam::RequestFailed)
    # end

    it "returns nil when vlan doesn't exist", :vcr do
      vlan = RubyPhpipam::Vlan.get(999)
      expect(vlan).to be_nil
    end

    it 'gets a vlan by id', :vcr do
      vlan = RubyPhpipam::Vlan.get(3)
      expect(vlan.vlanId).to eq 3
    end
  end

  context "method self.get_all" do
    it 'returns an empty array if there are no vlans', :vcr do
      vlans = RubyPhpipam::Vlan.get_all
      expect(vlans.count).to eq 0
    end

    it 'returns all vlans', :vcr do
      vlans = RubyPhpipam::Vlan.get_all
      vlans.each do |vlan|
        expect(vlan).to be_an_instance_of(RubyPhpipam::Vlan)
      end
    end
  end

  context 'method self.search' do
    it 'returns an empty array if no vlans match number', :vcr do
      vlans = RubyPhpipam::Vlan.search(99)
      expect(vlans.count).to eq 0
    end

    it 'returns all vlans that match the number', :vcr do
      vlans = RubyPhpipam::Vlan.search(13)
      vlans.each do |vlan|
        expect(vlan).to be_an_instance_of(RubyPhpipam::Vlan)
        expect(vlan.number).to eq 13
      end
    end
  end

  context 'method subnets' do
    it 'returns an empty array if vlan has no subnets', :vcr do
      vlan = RubyPhpipam::Vlan.get(1)
      expect(vlan.subnets.count).to eq 0
    end

    it 'returns all subnets belonging to the vlan', :vcr do
      vlan = RubyPhpipam::Vlan.get(3)
      vlan.subnets.each do |subnet|
        expect(subnet).to be_an_instance_of(RubyPhpipam::Subnet)
        expect(subnet.vlanId).to eq vlan.vlanId
      end
    end

    it 'returns an empty array if vlan has no subnets in a section', :vcr do
      vlan = RubyPhpipam::Vlan.get(4)
      expect(vlan.subnets(2).count).to eq 0
    end

    it 'returns all subnets in a section belonging to the vlan', :vcr do
      vlan = RubyPhpipam::Vlan.get(3)
      vlan.subnets(2).each do |subnet|
        expect(subnet).to be_an_instance_of(RubyPhpipam::Subnet)
        expect(subnet.vlanId).to eq vlan.vlanId
        expect(subnet.sectionId).to eq 2
      end
    end
  end
end