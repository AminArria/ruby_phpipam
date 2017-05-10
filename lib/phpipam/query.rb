module Phpipam
  class Query
    def self.get(url)
      Phpipam.auth.validate_token!

      response = HTTParty.get(Phpipam.gen_url(url),
          headers: {token: Phpipam.auth.token}
        )

      body = JSON.parse(response.body, symbolize_names: true)

      unless body[:success]
        raise RequestFailed.new(body[:code], body[:message])
      end

      body[:data]
    end
  end
end