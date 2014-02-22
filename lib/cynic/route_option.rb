module Cynic
  class RouteOption
    def initialize(hash={})
      @hash = hash
    end
    
    def [](route)
      key, regex = regex_for_key(route)
      object, method = @hash[key]
      Cynic::Route.new(object, method, params(route)) if object 
    end
    
    def params(route)
      key, regex = regex_for_key(route)
      return nil if regex.nil?
      matched_route = route.match(regex)
      Hash[matched_route.names.map(&:to_sym).zip(matched_route.captures)]
    end
    
    def regex_for_key(key)
      regexps.find {|k, regex| key.match regex }
    end
    
    def regexps
      @hash.keys.map {|key| [key, Regexp.new("^" + key.gsub(/:(.\w+)/, '(?<\1>\w+)') + "$")] }
    end
    
    def method_missing(method, *args)
      @hash.send(method, *args)
    end
  end
end