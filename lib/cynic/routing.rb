module Cynic
  class Routing
    class Error < StandardError;end
    
    def initialize()
      @routings = {get: {}, post: {}, patch: {}, delete: {}}
    end
    
    def define(&block)
      block.call(self).to_s
      self
    end
    
    def go_to(request_method, request_path)
      if action(request_method, request_path)
        action(request_method, request_path)
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
  end
end