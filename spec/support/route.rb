def defined_route
  Trail::Route.new.define do |map|
    map.get "/",       to: [String, :new]
    map.get "/blog",   to: [self, :rand]
    map.get "/trails", to: [Trail::Controller.new, :index]
  end
end