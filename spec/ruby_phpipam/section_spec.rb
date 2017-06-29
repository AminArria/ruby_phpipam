require "spec_helper"

RSpec.describe RubyPhpipam::Section do
  before :all do
    VCR.use_cassette("RubyPhpipam_Section/authenticate") do
      Timecop.freeze(VCR.current_cassette.originally_recorded_at || Time.now)
      load_configuration
      RubyPhpipam.authenticate
    end
  end

  context "method self.get" do
    it "raises an error when section doesn't exist", :vcr do
      expect {
        RubyPhpipam::Section.get(999)
      }.to raise_error(RubyPhpipam::RequestFailed)
    end

    it 'gets a section by id', :vcr do
      section = RubyPhpipam::Section.get(3)
      expect(section).to be_an_instance_of(RubyPhpipam::Section)
      expect(section.id).to eq 3
    end

    it 'gets a section by name', :vcr do
      section = RubyPhpipam::Section.get('Probando')
      expect(section).to be_an_instance_of(RubyPhpipam::Section)
      expect(section.name).to eq 'Probando'
    end
  end

  context "method self.get_all" do
    it 'gets all sections', :vcr do
      sections = RubyPhpipam::Section.get_all
      expect(sections.count).to eq 4

      sections.sort! {|a,b| a.id <=> b.id}
      4.times do |x|
        expect(sections[x]).to be_an_instance_of(RubyPhpipam::Section)
        expect(sections[x].id).to eq x+1
      end
    end
  end

  context "method subnets" do
    it 'returns an empty array if section has no subnets', :vcr do
      section = RubyPhpipam::Section.get('Vacia')
      subnets = section.subnets
      expect(subnets.count).to eq 0
    end

    it 'gets all subnets belonging to a section', :vcr do
      section = RubyPhpipam::Section.get('Probando')
      subnets = section.subnets

      subnets.each do |subnet|
        expect(subnet.sectionId).to eq section.id
      end
    end
  end
end
