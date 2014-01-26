require 'spec_helper'

describe Trail::Route do
  
  let(:route) { defined_route }

  it "calls the method to be returned" do
    expect(route.go_to(:get, "/")).to eq ""
  end
  
  it "calls the method to be returned" do
    expect(route.go_to(:get, "/blog")).to be_an_instance_of Float
  end
  
  it "returns the index" do
    Trail::Controller.any_instance.stub(:index).and_return("This is erb hello")
    expect(route.go_to(:get, "/trails")).to eq "This is erb hello"
  end
  
  it "raises an Route::Error when the path doesn't exist" do
    expect { route.go_to(:get, "/im-lost") }.to raise_error Trail::Route::Error, "undefined route GET '/im-lost'"
  end
  
end