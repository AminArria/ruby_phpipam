module RubyPhpipam
  class Vlan
    attr_reader :vlanId, :domainId, :name, :number, :description,  :editDate

    def initialize(json)
      @vlanId = RubyPhpipam::Helper.to_type(json[:vlanId], :int)
      @domainId = RubyPhpipam::Helper.to_type(json[:domainId], :int)
      @name = json[:name]
      @number = RubyPhpipam::Helper.to_type(json[:number], :int)
      @description = json[:description]
      @editDate = RubyPhpipam::Helper.to_type(json[:editDate], :date)
    end

    def self.get_all
      vlans = RubyPhpipam::Query.get_array('/vlan/')
      vlans.map do |vlan|
        Vlan.new(vlan)
      end
    end

    def self.get(id)
      # phpIPAM API created inconsistency between invalid ID responses
      # thus inconsistency with the wrapper.
      data = RubyPhpipam::Query.get("/vlan/#{id}/")
      data ? Vlan.new(data) : nil
    end

    def self.search(number)
      data = RubyPhpipam::Query.get_array("/vlan/search/#{number}/")

      data.map do |vlan|
        Vlan.new(vlan)
      end
    end

    def subnets(sectionId=nil)
      data = RubyPhpipam::Query.get_array("/vlan/#{vlanId}/subnets/")

      subnets = data.map do |subnet|
        RubyPhpipam::Subnet.new(subnet)
      end

      if sectionId
        subnets.keep_if { |x| x.sectionId == sectionId}
      end

      subnets
    end
  end
end