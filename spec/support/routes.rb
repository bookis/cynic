Trails.application.routing.define do |map|
  map.get "/",       to: [String, :new]
  map.get "/blog",   to: [self, :rand]
  map.get "/trails", to: [Trails::Controller.new, :index]
end
