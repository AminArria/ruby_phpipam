module RubyPhpipam
  class Subnet
    # Subnet attributes
    attr_reader :id, :subnet, :mask, :description, :sectionId, :linked_subnet,
                :vlanId, :vrfId, :masterSubnetId, :namerServerId, :showName,
                :permissions, :DNSrecursive, :DNSrecords, :allowResquests,
                :scanAgent, :pingSubnet, :discoverSubnet, :isFolder, :isFull,
                :state, :threshold, :location, :editDate

    # Subnet usage attributes
    attr_reader :used, :maxhosts, :freehosts, :freehosts_percent

    def initialize(json)
      @id = RubyPhpipam::Helper.to_type(json[:id], :int)
      @subnet = json[:subnet]
      @mask = RubyPhpipam::Helper.to_type(json[:mask], :int)
      @description = json[:description]
      @sectionId = RubyPhpipam::Helper.to_type(json[:sectionId], :int)
      @linked_subnet = RubyPhpipam::Helper.to_type(json[:linked_subnet], :int)
      @vlanId = RubyPhpipam::Helper.to_type(json[:vlanId], :int)
      @vrfId = RubyPhpipam::Helper.to_type(json[:vrfId], :int)
      @masterSubnetId = RubyPhpipam::Helper.to_type(json[:masterSubnetId], :int)
      @namerServerId = RubyPhpipam::Helper.to_type(json[:namerServerId], :int)
      @showName = RubyPhpipam::Helper.to_type(json[:showName], :binary)
      @permissions = RubyPhpipam::Helper.to_type(json[:permissions], :json)
      @DNSrecursive = RubyPhpipam::Helper.to_type(json[:DNSrecursive], :binary)
      @DNSrecords = RubyPhpipam::Helper.to_type(json[:DNSrecords], :binary)
      @allowResquests = RubyPhpipam::Helper.to_type(json[:allowResquests], :binary)
      @scanAgent = RubyPhpipam::Helper.to_type(json[:scanAgent], :binary)
      @pingSubnet = RubyPhpipam::Helper.to_type(json[:pingSubnet], :binary)
      @discoverSubnet = RubyPhpipam::Helper.to_type(json[:discoverSubnet], :binary)
      @isFolder = RubyPhpipam::Helper.to_type(json[:isFolder], :binary)
      @isFull = RubyPhpipam::Helper.to_type(json[:isFull], :binary)
      @state = RubyPhpipam::Helper.to_type(json[:state], :int)
      @threshold = RubyPhpipam::Helper.to_type(json[:threshold], :int)
      @location = RubyPhpipam::Helper.to_type(json[:location], :int)
      @editDate = RubyPhpipam::Helper.to_type(json[:editDate], :date)
    end

    def self.get(id)
      Subnet.new(RubyPhpipam::Query.get("/subnets/#{id}/"))
    end

    def self.search(cidr)
      unless RubyPhpipam::Helper.validate_cidr(cidr)
        raise WrongFormatSearch, "CIDR doesn't match CIDR format x.x.x.x/y"
      end

      base, mask = cidr.split("/")

      data = RubyPhpipam::Query.get("/subnets/cidr/#{base}/#{mask}/")

      if data.nil?
        return nil
      else
        # Currently Rubyphpipam gives the resonse to this query as an array
        # just containing the element.
        return Subnet.new(data[0])
      end
    end

    def usage
      data = RubyPhpipam::Query.get("/subnets/#{id}/usage/")

      @used = RubyPhpipam::Helper.to_type(data[:used], :int)
      @maxhosts = RubyPhpipam::Helper.to_type(data[:maxhosts], :int)
      @freehosts = RubyPhpipam::Helper.to_type(data[:freehosts], :int)
      @freehosts_percent = data[:freehosts_percent]

      return self
    end

    def addresses
      data = RubyPhpipam::Query.get_array("/subnets/#{id}/addresses/")

      data.map do |addr|
        RubyPhpipam::Address.new(addr)
      end
    end

    # This will need to wait for response to the issue created
    # https://github.com/Rubyphpipam/Rubyphpipam/issues/1217
    # def get_address(ip)
    #   data = RubyPhpipam::Query.get("/subnets/#{id}/addresses/#{ip}/")

    #   RubyPhpipam::Address.new(data)
    # end

    def first_free_ip
      # Should this raise an exception if no address available or return nil?
      # Currently it returns nil
      data = RubyPhpipam::Query.get("/subnets/#{id}/first_free/")
    end

    def slaves
      data = RubyPhpipam::Query.get_array("/subnets/#{id}/slaves/")

      data.map do |subnet|
        RubyPhpipam::Subnet.new(subnet)
      end
    end

    def slaves_recursive
      data = RubyPhpipam::Query.get_array("/subnets/#{id}/slaves_recursive/")

      data.map do |subnet|
        RubyPhpipam::Subnet.new(subnet)
      end
    end

    def first_subnet(mask)
      RubyPhpipam::Query.get("/subnets/#{id}/first_subnet/#{mask}/")
    end

    def all_subnets(mask)
      RubyPhpipam::Query.get_array("/subnets/#{id}/all_subnets/#{mask}/")
    end
  end
end