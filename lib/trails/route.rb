module Trail
  class Route
    class Error < StandardError;end
    
    def initialize()
      @routes = {get: {}, post: {}, patch: {}, delete: {}}
    end
    
    def define(&block)
      block.call(self).to_s
      self
    end
    
    def go_to(request_method, request_path)
      klass, action = @routes[request_method.to_sym][request_path]
      klass.send(action)
    rescue TypeError
      raise Error, "undefined route #{request_method.upcase} '#{request_path}'"
    end
    
    def get(path, options={})
      @routes[:get][path] = options[:to]
    end
  end
end