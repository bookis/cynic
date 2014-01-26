def defined_route(app=nil)
  route = app.nil? ? Trails::Route.new : app.route
  route.define do |map|
    map.get "/",       to: [String, :new]
    map.get "/blog",   to: [self, :rand]
    map.get "/trails", to: [Trails::Controller.new, :index]
  end
end