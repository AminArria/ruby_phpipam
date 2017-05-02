require "phpipam/version"
require "phpipam/configuration"

module Phpipam
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end
end
