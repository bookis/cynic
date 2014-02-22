require 'rack'
require "cynic/version"
require 'cynic/configuration'

module Cynic
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

require 'cynic/app'
require 'cynic/response'
require 'cynic/routing'
require 'cynic/controller'
require 'cynic/renderer'
require 'cynic/route_option'
