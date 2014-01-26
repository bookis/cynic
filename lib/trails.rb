require "trails/version"
require 'trails/configuration'

module Trails
  class << self
    attr_accessor :configuration
    
    def configure
      @configuration = Configuration.new
      yield(configuration) if block_given?
    end
  end
end

require 'trails/app'
require 'trails/response'
require 'trails/route'
require 'trails/controller'
require 'trails/renderer'
