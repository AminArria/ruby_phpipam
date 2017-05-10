module Phpipam
  class Section
    attr_reader :id, :name, :description, :masterSection, :permissions,
                :strictMode, :subnetOrdering, :order, :editDate, :showVLAN,
                :showVRF, :showSupernetOnly, :DNS

    def initialize(json)
      @id = json[:id].to_i
      @name = json[:name]
      @description = json[:description]
      @masterSection = json[:masterSection].to_i
      @permissions = JSON.parse(json[:permissions])
      @strictMode = json[:strictMode] == "0" ? false : true
      @subnetOrdering = json[:subnetOrdering]
      @order = json[:order].to_i
      @editDate = json[:editDate].nil? ? nil : Time.strptime(json[:editDate], '%Y-%m-%d %H:%M:%S')
      @showVLAN = json[:showVLAN] == "0" ? false : true
      @showVRF = json[:showVRF] == "0" ? false : true
      @showSupernetOnly = json[:showSupernetOnly] == "0" ? false : true
      @DNS = json[:DNS]
    end

    def self.get(id)
      Section.new(Phpipam::Query.get("/sections/#{id}/"))
    end

    def self.get_all
      data = Phpipam::Query.get("/sections/")

      sections = []
      data.each do |section|
        sections << Section.new(section)
      end

      return sections
    end

    def subnets
      data = Phpipam::Query.get("/sections/#{@id}/subnets/")

      subnets = []
      data.each do |subnet|
        subnets << Phpipam::Subnet.new(subnet)
      end

      return subnets
    end
  end
end