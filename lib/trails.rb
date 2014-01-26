require "trails/version"
require 'trails/configuration'

module Trails
  class << self
    attr_accessor :configuration, :application
    
    def configure
      @configuration = Configuration.new
      yield(configuration) if block_given?
    end
    
    def application
      @application ||= App.new
    end
  end
end

require 'trails/app'
require 'trails/response'
require 'trails/routing'
require 'trails/controller'
require 'trails/renderer'
