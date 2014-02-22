require "spec_helper"

describe Cynic::RouteOption do
  describe "regex find" do
    let(:hash) { Cynic::RouteOption.new({"/params/:user_id" => ["blah", :method]}) }
    it "finds value" do
      expect(hash["/params/1"].object).to eq "blah"
    end
    
    it "returns the params" do
      expect(hash.params("/params/1")[:user_id]).to eq "1"
    end
    
    context "when no match" do
      it "returns nil" do
        expect(hash["/no-route"]).to eq nil
      end
      
      it "returns nil" do
        expect(hash.params("/no-route")).to eq nil
      end
      
    end
  end
end