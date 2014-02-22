Cynic.application.routing.define do |map|
  map.get "/",       to: [String, :new]
  map.get "/blog",   to: [self, :rand]
  map.get  "/cynic", to: [Cynic::Controller.new, :index]
end
