module Trails
  class App
    attr_reader :route
    
    def initialize
      @route = Route.new
    end
    
    def call(env)
      @env = env
      send_response
    end
    
    def route_to_request
      route.go_to @env["REQUEST_METHOD"].downcase.to_sym, @env["REQUEST_URI"]
    end
    
    def send_response
      [status, headers, response]
    end
    
    def response
      Response.new(self.route_to_request)
    end
    
    def status
      200
    end
    
    def headers
      {"CONTENT-TYPE" => "text/html"}
    end
    
  end
end