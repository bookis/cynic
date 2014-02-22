def defined_routing(app=nil)
  routing = app.nil? ? Cynic::Routing.new : app.routing
  routing.define do |map|
    map.get "/",       to: [String, :new]
    map.get "/blog",   to: [String, :new]
    map.get "/cynic", to: [Cynic::Controller.new, :index]
    map.post "/blah", to: [Cynic::Controller.new, :index]
    map.get "/params/:id", to: [Cynic::Controller.new, :index]
  end
end