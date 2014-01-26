require 'spec_helper'

describe Trails do
  describe "configuration" do
    before { Trails.configure {|config| config.environment = :test } }
    it "has configuration" do
      expect(Trails.configuration).to be_an_instance_of Trails::Configuration
    end
  
    it "is test env" do
      expect(Trails.configuration.environment).to eq :test
    end
  
    it "can reassign env" do
      Trails.configuration.environment = :development
      expect(Trails.configuration.environment).to eq :development
    end
  
    context "no block given" do
      it "doesn't bork" do
        expect { Trails.configure }.to_not raise_error
      end
    
      it "still assigns a config object" do
        Trails.configure
        expect(Trails.configuration).to be_an_instance_of Trails::Configuration
      end
    
    end
  end
end