module RubyPhpipam
  class Configuration
    attr_accessor :base_url, :username, :password

    def initialize
      @base_url = nil
      @username = nil
      @password = nil
    end
  end
end