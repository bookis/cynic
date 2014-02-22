require 'spec_helper'

describe Cynic::Routing do
  
  let(:routing) { defined_routing }

  it "calls the method to be returned" do
    expect(routing.go_to(:get, "/").method).to eq :new
  end
  
  it "returns the index" do
    Cynic::Controller.any_instance.stub(:index).and_return("This is erb hello")
    expect(routing.go_to(:get, "/cynic").first).to be_an_instance_of Cynic::Controller
  end
  
  it "raises an Routing::Error when the path doesn't exist" do
    expect { routing.go_to(:get, "/im-lost") }.to raise_error Cynic::Routing::Error, "undefined routing GET '/im-lost'"
  end
  
  describe "POST" do
    
    it "can set a post" do
      route = Cynic::Routing.new
      route.post "/blah", to: [String, :new]
      expect(route.go_to(:post, "/blah").first).to eq String
    end
    
    it "can render text" do
      expect(routing.go_to(:post, "/blah").first).to be_an_instance_of Cynic::Controller
    end
  end
  
  describe "#params" do
    
    it "recognizes the path with a named parameter" do
      expect(routing.go_to(:get, "/params/1").params).to eq({id: "1"})
    end
    
  end
  
end