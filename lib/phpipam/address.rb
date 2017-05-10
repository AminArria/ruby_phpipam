module Phpipam
  class Address
    attr_reader :id, :subnetId, :ip, :is_gateway, :description, :hostname,
                :mac, :owner, :tag, :PTRignore, :PTR, :deviceId, :port, :note,
                :lastSeen, :excludePing, :editDate

    def initialize(json)
      @id = json[:id].to_i
      @subnetId = json[:subnetId].to_i
      @ip = json[:ip]
      @is_gateway = json[:is_gateway] == "0" ? false : true
      @description = json[:description]
      @hostname = json[:hostname]
      @mac = json[:mac]
      @owner = json[:owner]
      @tag = json[:tag].to_i
      @PTRignore = json[:PTRignore] == "0" ? false : true
      @PTR = json[:PTR].to_i
      @deviceId = json[:deviceId].to_i
      @port = json[:port]
      @note = json[:note]
      @lastSeen = json[:lastSeen] == "0000-00-00 00:00:00" ? nil : Time.strptime(json[:lastSeen], '%Y-%m-%d %H:%M:%S')
      @excludePing = json[:excludePing] == "0" ? false : true
      @editDate = json[:editDate].nil? ? nil : Time.strptime(json[:editDate], '%Y-%m-%d %H:%M:%S')
    end

    def self.get(id)
      Address.new(Phpipam::Query.get("/addresses/#{id}/"))
    end
  end
end