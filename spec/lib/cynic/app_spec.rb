require 'spec_helper'

describe Cynic::App do
  let(:env) { {"REQUEST_METHOD" => "GET", "REQUEST_PATH" => "/cynic"} }
  let(:cynic) { Cynic.application }
  before { require "support/routes" }
  
  describe "#routing" do
    it "returns a routing object" do
      expect(cynic.routing).to be_an_instance_of Cynic::Routing
    end
  end
  
  describe "#call" do
    before do 
      Cynic::Controller.any_instance.stub(:index).and_return("This is erb hello")
    end
    
    it "responds to call" do
      expect(cynic).to respond_to(:call)
    end
  
    it "returns an array" do
      expect(cynic.call(env)).to be_an_instance_of Array
    end
    
    describe "the returned array" do
      it "0 returns 200" do
        expect(cynic.call(env)[0]).to eq 200
      end
      it "1 returns a Hash" do
        expect(cynic.call(env)[1]).to be_an_instance_of Hash
      end
      it "2 returns something that responds to `each`" do
        expect(cynic.call(env)[2]).to respond_to :each
      end
      
      it "has a response object with a body" do
        expect(cynic.call(env)[2].body).to eq "This is erb hello"
      end
    end
    
  end
end