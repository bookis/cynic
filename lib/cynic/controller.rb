module Cynic
  class Controller
    def render(action)
      @action = action
      Renderer.new(full_path).body
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
  end
end