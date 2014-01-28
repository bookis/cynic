require 'spec_helper'

describe Cynic::Response do
  let(:response) { Cynic::Response.new("This is the body") }
  describe "#each" do
    it "responds" do
      expect(response).to respond_to :each
    end
    
    it "responds with the body" do
      expect(response.each {|k| k }).to eq "This is the body"
    end
  end
end