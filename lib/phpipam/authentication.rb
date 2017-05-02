require 'httparty'

module Phpipam
  class Authentication
    def self.authenticate
      response = HTTParty.post(Phpipam.gen_url("/user/"),
          { basic_auth: { username: Phpipam.configuration.username,
                         password: Phpipam.configuration.password
                        }
          }
        )

      if response.body == "Authentication failed"
        raise AuthenticationFailed, "Authentication with given credentials failed."
      end

      body = JSON.parse(response.body, symbolize_names: true)

      unless body[:success]
        raise RequestFailed.new(body[:code], body[:message])
      end

      Phpipam.token = body[:data][:token]
    end
  end
end