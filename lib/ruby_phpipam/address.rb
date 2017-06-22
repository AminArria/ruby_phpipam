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
  end
end