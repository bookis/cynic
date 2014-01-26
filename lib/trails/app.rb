module Trails
  class App
    def initialize(routing=nil)
      @routing = routing || Route.new
    end
    
    def call(env)
      @env = env
      send_response
    end
    
    def route
      @routing.go_to @env["REQUEST_METHOD"].downcase.to_sym, @env["REQUEST_URI"]
    end
    
    def send_response
      [status, headers, response]
    end
    
    def response
      Response.new(route)
    end
    
    def status
      200
    end
    
    def headers
      {"CONTENT-TYPE" => "text/html"}
    end
    
  end
end