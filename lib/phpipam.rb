require 'httparty'

require "phpipam/version"
require "phpipam/configuration"
require "phpipam/authentication"
require "phpipam/exceptions"

module Phpipam
  class << self
    attr_accessor :configuration
    attr_accessor :token
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  def self.gen_url(url)
    "#{Phpipam.configuration.base_url}#{url}"
  end
end
