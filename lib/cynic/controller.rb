module Cynic
  class Controller
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
      execute_before_actions
      Renderer.new(full_path, self).body
    end

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
    
    private
    
    def execute_before_actions
      eval_set_of_actions
      eval_set_of_actions(@action)
    end
    
    def eval_set_of_actions(set=:all)
      self.class.before_actions[set].each {|action| eval(action.to_s)}
    end
  end
end