module Cynic
  class Route
    attr_accessor :params, :object, :method
    def initialize(object, method, params={})
      @object = object
      @method = method
      @params = params
    end
    
    def method_missing(method, *args)
      [@object, @method, @params].send(method, *args)
    end
    
  end
  class Routing
    class Error < StandardError;end
    
    def initialize()
      @routings = {
        get:    Cynic::RouteOption.new, 
        post:   Cynic::RouteOption.new, 
        patch:  Cynic::RouteOption.new, 
        delete: Cynic::RouteOption.new
      }
    end
    
    def define(&block)
      block.call(self).to_s
      self
    end
    
    def go_to(request_method, request_path)
      route = action(request_method, request_path)
      if route
        route
      else
        raise Error, "undefined routing #{request_method.upcase} '#{request_path}'"
      end
    end
    
    def action(request_method, request_path)
      @routings[request_method.to_sym][request_path]
    end
    
    def get(path, options={})
      @routings[:get][path] = options[:to]
    end
    
    def post(path, options={})
      @routings[:post][path] = options[:to]
    end
  end
end