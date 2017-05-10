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
      @id = json[:id].to_i
      @subnet = json[:subnet]
      @mask = json[:mask].to_i
      @description = json[:description]
      @sectionId = json[:sectionId].to_i
      @linked_subnet = json[:linked_subnet].to_i
      @vlanId = json[:vlanId].to_i
      @vrfId = json[:vrfId].to_i
      @masterSubnetId = json[:masterSubnetId].to_i
      @namerServerId = json[:namerServerId].to_i
      @showName = json[:showName] == "0" ? false : true
      @permissions = JSON.parse(json[:permissions])
      @DNSrecursive = json[:DNSrecursive] == "0" ? false : true
      @DNSrecords = json[:DNSrecords] == "0" ? false : true
      @allowResquests = json[:allowResquests] == "0" ? false : true
      @scanAgent = json[:scanAgent] == "0" ? false : true
      @pingSubnet = json[:pingSubnet] == "0" ? false : true
      @discoverSubnet = json[:discoverSubnet] == "0" ? false : true
      @isFolder = json[:isFolder] == "0" ? false : true
      @isFull = json[:isFull] == "0" ? false : true
      @state = json[:state].to_i
      @threshold = json[:threshold].to_i
      @location = json[:location].to_i
      @editDate = json[:editDate].nil? ? nil : Time.strptime(json[:editDate], '%Y-%m-%d %H:%M:%S')
    end

    def self.get(id)
      Subnet.new(Phpipam::Query.get("/subnets/#{id}/"))
    end

    def usage
      data = Phpipam::Query.get("/subnets/#{id}/usage/")

      @used = data[:used]
      @maxhosts = data[:maxhosts]
      @freehosts = data[:freehosts]
      @freehosts_percent = data[:freehosts_percent]

      return self
    end

    def addresses
      data = Phpipam::Query.get("/subnets/#{id}/addresses/")

      addrs = []
      data.each do |addr|
        addrs << Phpipam::Address.new(addr)
      end

      return addrs
    end
  end
end