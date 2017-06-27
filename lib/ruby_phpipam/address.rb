module RubyPhpipam
  class Address
    attr_reader :id, :subnetId, :ip, :is_gateway, :description, :hostname,
                :mac, :owner, :tag, :PTRignore, :PTR, :deviceId, :port, :note,
                :lastSeen, :excludePing, :editDate

    def initialize(json)
      @id = RubyPhpipam::Helper.to_type(json[:id], :int)
      @subnetId = RubyPhpipam::Helper.to_type(json[:subnetId], :int)
      @ip = json[:ip]
      @is_gateway = RubyPhpipam::Helper.to_type(json[:is_gateway], :binary)
      @description = json[:description]
      @hostname = json[:hostname]
      @mac = json[:mac]
      @owner = json[:owner]
      @tag = RubyPhpipam::Helper.to_type(json[:tag], :int)
      @PTRignore = RubyPhpipam::Helper.to_type(json[:PTRignore], :binary)
      @PTR = RubyPhpipam::Helper.to_type(json[:PTR], :int)
      @deviceId = RubyPhpipam::Helper.to_type(json[:deviceId], :int)
      @port = json[:port]
      @note = json[:note]
      @lastSeen = RubyPhpipam::Helper.to_type(json[:lastSeen], :date)
      @excludePing = RubyPhpipam::Helper.to_type(json[:excludePing], :binary)
      @editDate = RubyPhpipam::Helper.to_type(json[:editDate], :date)
    end

    def self.get(id)
      Address.new(RubyPhpipam::Query.get("/addresses/#{id}/"))
    end

    def self.ping(id)
      response = RubyPhpipam::Query.get("/addresses/#{id}/ping/")

      if response[:exit_code] == 0
        return true
      else
        return false
      end
    end

    def self.search(ip:nil, hostname:nil, subnetId:nil)
      if !ip.nil?
        if subnetId.nil?
          addresses = RubyPhpipam::Query.get_array("/addresses/search/#{ip}/")
        else
          address = RubyPhpipam::Query.get("/addresses/#{ip}/#{subnetId}/")
        end
      else
        addresses = RubyPhpipam::Query.get_array("/addresses/search_hostname/#{hostname}/")
      end

      return (address ? self.new(address) : nil) if subnetId

      addresses.map do |address|
        self.new(address)
      end
    end

    def self.first_free(subnetId)
      RubyPhpipam::Query.get("/addresses/first_free/#{subnetId}/")
    end

    def online?
      RubyPhpipam::Address.ping(@id)
    end
  end
end