# External gems
require 'httparty'

# Support Libraries
require "ruby_phpipam/version"
require "ruby_phpipam/configuration"
require "ruby_phpipam/authentication"
require "ruby_phpipam/exceptions"
require "ruby_phpipam/query"
require "ruby_phpipam/helper"

# API Libraries
require "ruby_phpipam/address"
require "ruby_phpipam/subnet"
require "ruby_phpipam/section"
require "ruby_phpipam/vlan"

module RubyPhpipam
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
    "#{RubyPhpipam.configuration.base_url}#{url}"
  end
end
