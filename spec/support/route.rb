def defined_routing(app=nil)
  routing = app.nil? ? Trails::Routing.new : app.routing
  routing.define do |map|
    map.get "/",       to: [String, :new]
    map.get "/blog",   to: [self, :rand]
    map.get "/trails", to: [Trails::Controller.new, :index]
  end
end