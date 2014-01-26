module Trail
  class Renderer
    def initialize(path)
      @full_path = path_prefix + path
      @layout    = path_prefix + "layouts/application.html.erb"
    end
    
    def body
      layout { ERB.new(File.read(@full_path)).result }
    end
    
    def layout 
      ERB.new(layout_file || "<%= yield %>").result(binding)
    end
    
    def layout_file
      layout_exists? ? File.read(@layout) : "<%= yield %>"
    end
    
    def path_prefix
      "views/"
    end
    
    def layout_exists?
      File.exists? @layout
    end
    
  end
end