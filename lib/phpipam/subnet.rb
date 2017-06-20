module Phpipam
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
      @id = Phpipam::Helper.to_type(json[:id], :int)
      @subnet = json[:subnet]
      @mask = Phpipam::Helper.to_type(json[:mask], :int)
      @description = json[:description]
      @sectionId = Phpipam::Helper.to_type(json[:sectionId], :int)
      @linked_subnet = Phpipam::Helper.to_type(json[:linked_subnet], :int)
      @vlanId = Phpipam::Helper.to_type(json[:vlanId], :int)
      @vrfId = Phpipam::Helper.to_type(json[:vrfId], :int)
      @masterSubnetId = Phpipam::Helper.to_type(json[:masterSubnetId], :int)
      @namerServerId = Phpipam::Helper.to_type(json[:namerServerId], :int)
      @showName = Phpipam::Helper.to_type(json[:showName], :binary)
      @permissions = Phpipam::Helper.to_type(json[:permissions], :json)
      @DNSrecursive = Phpipam::Helper.to_type(json[:DNSrecursive], :binary)
      @DNSrecords = Phpipam::Helper.to_type(json[:DNSrecords], :binary)
      @allowResquests = Phpipam::Helper.to_type(json[:allowResquests], :binary)
      @scanAgent = Phpipam::Helper.to_type(json[:scanAgent], :binary)
      @pingSubnet = Phpipam::Helper.to_type(json[:pingSubnet], :binary)
      @discoverSubnet = Phpipam::Helper.to_type(json[:discoverSubnet], :binary)
      @isFolder = Phpipam::Helper.to_type(json[:isFolder], :binary)
      @isFull = Phpipam::Helper.to_type(json[:isFull], :binary)
      @state = Phpipam::Helper.to_type(json[:state], :int)
      @threshold = Phpipam::Helper.to_type(json[:threshold], :int)
      @location = Phpipam::Helper.to_type(json[:location], :int)
      @editDate = Phpipam::Helper.to_type(json[:editDate], :date)
    end

    def self.get(id)
      Subnet.new(Phpipam::Query.get("/subnets/#{id}/"))
    end

    def self.search(cidr)
      unless Phpipam::Helper.validate_cidr(cidr)
        raise WrongFormatSearch, "CIDR doesn't match CIDR format x.x.x.x/y"
      end

      base, mask = cidr.split("/")

      data = Phpipam::Query.get("/subnets/cidr/#{base}/#{mask}/")

      # Currently phpipam gives the resonse to this query as an array
      # just containing the element.
      return Subnet.new(data[0])
    end

    def usage
      data = Phpipam::Query.get("/subnets/#{id}/usage/")

      @used = Phpipam::Helper.to_type(data[:used], :int)
      @maxhosts = Phpipam::Helper.to_type(data[:maxhosts], :int)
      @freehosts = Phpipam::Helper.to_type(data[:freehosts], :int)
      @freehosts_percent = data[:freehosts_percent]

      return self
    end

    def addresses
      data = Phpipam::Query.get_array("/subnets/#{id}/addresses/")

      data.map do |addr|
        Phpipam::Address.new(addr)
      end
    end

    def first_free_ip
      # Should this raise an exception if no address available or return nil?
      # Currently it returns nil
      data = Phpipam::Query.get("/subnets/#{id}/first_free/")
    end

    def slaves
      data = Phpipam::Query.get_array("/subnets/#{id}/slaves/")

      data.map do |subnet|
        Phpipam::Subnet.new(subnet)
      end
    end
  end
end