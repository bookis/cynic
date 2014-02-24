module Cynic
  class Controller
    attr_accessor :request
    class << self
      attr_accessor :before_actions
      
      def before_actions
        @before_actions ||= Hash.new { Set.new }
      end
      
      def before_action(method, options={})
        if options.has_key? :only
          [options[:only]].flatten.each { |action|  add_before_action(method, action) }
        else
          add_before_action(method)
        end
      end
      
      def add_before_action(method, action=:all)
        before_actions[action] <<= method
      end
    end
    
    def render(action)
      @action = action
      Renderer.new(full_path, self).body
    end
    
    def response(method)
      eval_set_of_actions
      eval_set_of_actions(method)
      send method
    end

    def params
      request.params.each do |k,v|
        request.update_param(k.to_sym, v) if k.is_a? String
      end
      
      request.params
    end
    
    private
    
    # The +name+ split and joined into a string seperated by "/"'s
    def path
      name.split("::").join("/").downcase
    end
    
    # The +path+ plus the current action.html.erb
    def full_path
      path + "/#{@action}.html.erb"
    end
    
    # The Controllers class name without the word `controller` in it.
    def name
      self.class.to_s.gsub(/controller$/i, "")
    end    
    
    def eval_set_of_actions(set=:all)
      self.class.before_actions[set].each {|action| eval(action.to_s)}
    end
  end
end