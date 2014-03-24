module Cynic
  class App
    attr_reader :routing
    
    def self.initialize!
      Cynic.application = self.new
      require './config/routes'
      builder = Rack::Builder.new
      builder.use Rack::Static, :urls => ["/javascripts", "/stylesheets", "/images" "/bower_components"], :root => "public"
      builder.run Cynic.application
      builder
    end
    
    def initialize
      Cynic.application = self
      @routing = Routing.new
    end
    
    def call(env)
      @env = env
      response.send
    end
    
    def request
      Rack::Request.new(@env)
    end
    
    def routing_to_request
      routing.go_to request.request_method.downcase.to_sym, @env["REQUEST_PATH"]
    end
    
    def response
      Response.new(execute_controller_actions, request)
    end
    
    def execute_controller_actions
      route = self.routing_to_request
      
      route.params.each do |k,v|
        request.update_param(k, v)
      end
      route.object.request = request 
      
      route.object.response(route.method)
    end
    
  end
end