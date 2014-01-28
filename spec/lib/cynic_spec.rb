require 'spec_helper'

describe Cynic do
  describe "configuration" do
    before { Cynic.configure {|config| config.environment = :test } }
    it "has configuration" do
      expect(Cynic.configuration).to be_an_instance_of Cynic::Configuration
    end
  
    it "is test env" do
      expect(Cynic.configuration.environment).to eq :test
    end
  
    it "can reassign env" do
      Cynic.configuration.environment = :development
      expect(Cynic.configuration.environment).to eq :development
    end
  
    context "no block given" do
      it "doesn't bork" do
        expect { Cynic.configure }.to_not raise_error
      end
    
      it "still assigns a config object" do
        Cynic.configure
        expect(Cynic.configuration).to be_an_instance_of Cynic::Configuration
      end
    
    end
  end
end