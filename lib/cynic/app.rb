module Cynic
  class App
    attr_reader :routing
    
    def self.initialize!
      Cynic.application = self.new
      require './config/routes'
      builder = Rack::Builder.new
      builder.use Rack::Static, :urls => ["/javascripts", "/stylesheets", "/images"], :root => "public"
      builder.run Cynic.application
      builder
    end
    
    def initialize
      Cynic.application = self
      @routing = Routing.new
    end
    
    def call(env)
      @env = env
      send_response
    end
    
    def routing_to_request
      routing.go_to @env["REQUEST_METHOD"].downcase.to_sym, @env["REQUEST_PATH"]
    end
    
    def send_response
      [status, headers, response]
    end
    
    def response
      Response.new(execute_controller_actions)
    end
    
    def execute_controller_actions
      object, method = self.routing_to_request
      object.response(method)
    end
    
    def status
      200
    end
    
    def headers
      {"CONTENT-TYPE" => "text/html"}
    end
    
  end
end