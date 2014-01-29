require 'spec_helper'

describe Cynic::Routing do
  
  let(:routing) { defined_routing }

  it "calls the method to be returned" do
    expect(routing.go_to(:get, "/")).to eq [String, :new]
  end
  
  it "calls the method to be returned" do
    expect(routing.go_to(:get, "/blog").last).to eq :rand
  end
  
  it "returns the index" do
    Cynic::Controller.any_instance.stub(:index).and_return("This is erb hello")
    expect(routing.go_to(:get, "/cynic").first).to be_an_instance_of Cynic::Controller
  end
  
  it "raises an Routing::Error when the path doesn't exist" do
    expect { routing.go_to(:get, "/im-lost") }.to raise_error Cynic::Routing::Error, "undefined routing GET '/im-lost'"
  end
  
end