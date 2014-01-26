module Trails
  class App
    attr_reader :routing
    
    def self.initialize!
      self.new
      require './config/routes'
    end
    
    def initialize
      Trails.application = self
      @routing = Routing.new
    end
    
    def call(env)
      @env = env
      send_response
    end
    
    def routing_to_request
      routing.go_to @env["REQUEST_METHOD"].downcase.to_sym, @env["REQUEST_URI"]
    end
    
    def send_response
      [status, headers, response]
    end
    
    def response
      Response.new(self.routing_to_request)
    end
    
    def status
      200
    end
    
    def headers
      {"CONTENT-TYPE" => "text/html"}
    end
    
  end
end