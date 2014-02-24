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
    
    def request
      @request ||= Rack::Request.new(@env)
    end
    
    def routing_to_request
      routing.go_to request.request_method.downcase.to_sym, @env["REQUEST_PATH"]
    end
    
    def send_response
      [status, headers, response]
    end
    
    def response
      Response.new(execute_controller_actions)
    end
    
    def execute_controller_actions
      route = self.routing_to_request
      if route.object.respond_to? :request=
        route.params.each do |k,v|
          request.update_param(k, v)
        end
        route.object.request = request 
      end
      route.object.response(route.method)
    end
    
    def status
      200
    end
    
    def content_type
      request.content_type || "text/html"
    end
    
    def headers
      {"CONTENT-TYPE" => content_type}
    end
    
  end
end