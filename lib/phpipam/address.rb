module Phpipam
  class Address
    attr_reader :id, :subnetId, :ip, :is_gateway, :description, :hostname,
                :mac, :owner, :tag, :PTRignore, :PTR, :deviceId, :port, :note,
                :lastSeen, :excludePing, :editDate

    def initialize(json)
      @id = Phpipam::Helper.to_type(json[:id], :int)
      @subnetId = Phpipam::Helper.to_type(json[:subnetId], :int)
      @ip = json[:ip]
      @is_gateway = Phpipam::Helper.to_type(json[:is_gateway], :binary)
      @description = json[:description]
      @hostname = json[:hostname]
      @mac = json[:mac]
      @owner = json[:owner]
      @tag = Phpipam::Helper.to_type(json[:tag], :int)
      @PTRignore = Phpipam::Helper.to_type(json[:PTRignore], :binary)
      @PTR = Phpipam::Helper.to_type(json[:PTR], :int)
      @deviceId = Phpipam::Helper.to_type(json[:deviceId], :int)
      @port = json[:port]
      @note = json[:note]
      @lastSeen = Phpipam::Helper.to_type(json[:lastSeen], :date)
      @excludePing = Phpipam::Helper.to_type(json[:excludePing], :binary)
      @editDate = Phpipam::Helper.to_type(json[:editDate], :date)
    end

    def self.get(id)
      Address.new(Phpipam::Query.get("/addresses/#{id}/"))
    end
  end
end