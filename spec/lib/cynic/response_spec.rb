require 'spec_helper'

describe Cynic::Response do
  let(:env) { {"REQUEST_METHOD" => "GET", "REQUEST_PATH" => "/cynic", "rack.input" => "wtf", "CONTENT_TYPE" => "text/json"} }
  let(:response) { Cynic::Response.new("This is the body", Rack::Request.new(env)) }
  describe "#each" do
    it "responds" do
      expect(response).to respond_to :each
    end
    
    it "responds with the body" do
      expect(response.each {|k| k }).to eq "This is the body"
    end
  end
  
  describe "content_type" do
    it "sets it to json" do
      expect(response.content_type).to eq "text/json"
    end
    
    it "sets it to html if unknown" do
      env["CONTENT_TYPE"] = "app/something"
      expect(response.content_type).to eq "text/html"
    end
    
    it "the params takes prority" do
      env["QUERY_STRING"] = "format=jsonp"
      expect(response.content_type).to eq "text/jsonp"
    end
  end
end