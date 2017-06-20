module Phpipam
  class Section
    attr_reader :id, :name, :description, :masterSection, :permissions,
                :strictMode, :subnetOrdering, :order, :editDate, :showVLAN,
                :showVRF, :showSupernetOnly, :DNS

    def initialize(json)
      @id = Phpipam::Helper.to_type(json[:id], :int)
      @name = json[:name]
      @description = json[:description]
      @masterSection = Phpipam::Helper.to_type(json[:masterSection], :int)
      @permissions = Phpipam::Helper.to_type(json[:permissions], :json)
      @strictMode = Phpipam::Helper.to_type(json[:strictMode], :binary)
      @subnetOrdering = json[:subnetOrdering]
      @order = Phpipam::Helper.to_type(json[:order], :int)
      @editDate = Phpipam::Helper.to_type(json[:editDate], :date)
      @showVLAN = Phpipam::Helper.to_type(json[:showVLAN], :binary)
      @showVRF = Phpipam::Helper.to_type(json[:showVRF], :binary)
      @showSupernetOnly = Phpipam::Helper.to_type(json[:showSupernetOnly], :binary)
      @DNS = json[:DNS]
    end

    def self.get(id_or_name)
      Section.new(Phpipam::Query.get("/sections/#{id_or_name}/"))
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
      data = Phpipam::Query.get_array("/sections/#{@id}/subnets/")

      data.map do |subnet|
        Phpipam::Subnet.new(subnet)
      end
    end
  end
end