require "spec_helper"

RSpec.describe RubyPhpipam::Section do
  before :each do
    load_configuration
    RubyPhpipam.authenticate
  end

  it "raises an error when section doesn't exist", :vcr do
    expect {
      RubyPhpipam::Section.get(999)
    }.to raise_error(RubyPhpipam::RequestFailed)
  end

  it 'gets a section by id', :vcr do
    section = RubyPhpipam::Section.get(3)
    expect(section.id).to eq 3
  end

  it 'gets a section by name', :vcr do
    section = RubyPhpipam::Section.get('Probando')
    expect(section.name).to eq 'Probando'
  end

  it 'gets all sections', :vcr do
    sections = RubyPhpipam::Section.get_all
    expect(sections.count).to eq 4

    sections.sort! {|a,b| a.id <=> b.id}
    4.times do |x|
      expect(sections[x].id).to eq x+1
    end
  end

  it 'gets all subnets belonging to a section', :vcr do
    section = RubyPhpipam::Section.get('Probando')
    subnets = section.subnets

    subnets.each do |subnet|
      expect(subnet.sectionId).to eq section.id
    end
  end
end
