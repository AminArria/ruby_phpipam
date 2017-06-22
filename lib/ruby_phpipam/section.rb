module RubyPhpipam
  class Section
    attr_reader :id, :name, :description, :masterSection, :permissions,
                :strictMode, :subnetOrdering, :order, :editDate, :showVLAN,
                :showVRF, :showSupernetOnly, :DNS

    def initialize(json)
      @id = RubyPhpipam::Helper.to_type(json[:id], :int)
      @name = json[:name]
      @description = json[:description]
      @masterSection = RubyPhpipam::Helper.to_type(json[:masterSection], :int)
      @permissions = RubyPhpipam::Helper.to_type(json[:permissions], :json)
      @strictMode = RubyPhpipam::Helper.to_type(json[:strictMode], :binary)
      @subnetOrdering = json[:subnetOrdering]
      @order = RubyPhpipam::Helper.to_type(json[:order], :int)
      @editDate = RubyPhpipam::Helper.to_type(json[:editDate], :date)
      @showVLAN = RubyPhpipam::Helper.to_type(json[:showVLAN], :binary)
      @showVRF = RubyPhpipam::Helper.to_type(json[:showVRF], :binary)
      @showSupernetOnly = RubyPhpipam::Helper.to_type(json[:showSupernetOnly], :binary)
      @DNS = json[:DNS]
    end

    def self.get(id_or_name)
      Section.new(RubyPhpipam::Query.get("/sections/#{id_or_name}/"))
    end

    def self.get_all
      data = RubyPhpipam::Query.get("/sections/")

      sections = []
      data.each do |section|
        sections << Section.new(section)
      end

      return sections
    end

    def subnets
      data = RubyPhpipam::Query.get_array("/sections/#{@id}/subnets/")

      data.map do |subnet|
        RubyPhpipam::Subnet.new(subnet)
      end
    end
  end
end