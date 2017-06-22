module RubyPhpipam
  class Authentication
    attr_reader :token, :expires

    def initialize
      response = HTTParty.post(RubyPhpipam.gen_url("/user/"),
          { basic_auth: { username: RubyPhpipam.configuration.username,
                         password: RubyPhpipam.configuration.password
                        }
          }
        )

      body = JSON.parse(response.body, symbolize_names: true)
      unless body[:message].nil?
        raise AuthenticationFailed, body[:message]
      end

      unless body[:success]
        raise RequestFailed.new(body[:code], body[:message])
      end

      @token = body[:data][:token]
      @expires = Time.strptime(body[:data][:expires], '%Y-%m-%d %H:%M:%S')
    end

    def validate_token!
      if @expires <= Time.now
        data = RubyPhpipam::Query.get("/user/")

        if data[:expires] <= Time.now
          # Pending re authentication
        else
          @expires = data[:expires]
        end
      end
    end
  end
end