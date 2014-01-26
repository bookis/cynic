require 'spec_helper'

describe Trails::App do
  let(:env) { {"REQUEST_METHOD" => "GET", "REQUEST_URI" => "/trails"} }
  describe "#call" do
    let(:trail) { Trails::App.new(defined_route) }
    
    before do 
      Trails::Controller.any_instance.stub(:index).and_return("This is erb hello")
      trail.stub(:routing) { defined_route }
    end
    
    it "responds to call" do
      expect(trail).to respond_to(:call)
    end
  
    it "returns an array" do
      expect(trail.call(env)).to be_an_instance_of Array
    end
    
    describe "the returned array" do
      it "0 returns 200" do
        expect(trail.call(env)[0]).to eq 200
      end
      it "1 returns a Hash" do
        expect(trail.call(env)[1]).to be_an_instance_of Hash
      end
      it "2 returns something that responds to `each`" do
        expect(trail.call(env)[2]).to respond_to :each
      end
      
      it "has a response object with a body" do
        expect(trail.call(env)[2].body).to eq "This is erb hello"
      end
    end
    
  end
end