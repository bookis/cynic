module Trail
  class Controller
    def render(action)
      @action = action
      Renderer.new(full_path).body
    end

    def path
      self.class.to_s.split("::").join("/").downcase
    end
    
    def full_path
      path + "/#{@action}.html.erb"
    end
  end
end