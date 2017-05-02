module Phpipam
  # Abstract exception
  class Error < StandardError; end

  # Raised when authentication fails.
  class AuthenticationFailed < Error; end

  # Raised when response success is false.
  class RequestFailed < Error
    attr_reader :code, :message

    def initialize(code = nil, message = nil)
      @code = code
      @message = message
    end

    def to_s
      "Error code: #{code}, message: #{message}"
    end
  end
end