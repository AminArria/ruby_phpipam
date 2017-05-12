# External gems
require 'httparty'

# Support Libraries
require "phpipam/version"
require "phpipam/configuration"
require "phpipam/authentication"
require "phpipam/exceptions"
require "phpipam/query"
require "phpipam/helper"

# API Libraries
require "phpipam/address"
require "phpipam/subnet"
require "phpipam/section"

module Phpipam
  class << self
    attr_accessor :configuration
    attr_accessor :auth
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  def self.authenticate
    self.auth ||= Authentication.new
  end

  def self.gen_url(url)
    "#{Phpipam.configuration.base_url}#{url}"
  end
end
