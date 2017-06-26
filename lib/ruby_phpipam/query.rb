module RubyPhpipam
  class Query
    def self.get(url)
      RubyPhpipam.auth.validate_token!

      response = HTTParty.get(RubyPhpipam.gen_url(url),
          headers: {token: RubyPhpipam.auth.token}
        )

      body = JSON.parse(response.body, symbolize_names: true)

      unless body[:success] && body[:code] >= 200 && body[:code] < 400
        raise RequestFailed.new(body[:code], body[:message])
      end

      body[:data]
    end

    def self.get_array(url)
      data = self.get(url)

      return [] if data.nil?
      return data
    end
  end
end