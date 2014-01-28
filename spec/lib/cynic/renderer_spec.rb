require 'spec_helper'

describe Cynic::Renderer do
  path = "cynic/controller/index.html.erb"
  
  describe "#render" do
    let(:renderer) { Cynic::Renderer.new(path) }
    it "finds a file" do
      File.should_receive(:read).with("app/views/" + path).and_return('This is erb <%= "olleh".reverse %>')
      expect(renderer.body).to eq "This is erb hello"
    end
    
    it "finds a file with a layout" do
      Cynic::Renderer.any_instance.stub(:layout_file).and_return("Layout: <%= yield %> :file" )
      File.should_receive(:read).with("app/views/" + path).and_return('This is erb <%= "olleh".reverse %>')
      expect(renderer.body).to eq "Layout: This is erb hello :file"
    end
  end
  
  describe "controller" do
    let(:controller) { Cynic::Controller.new }
    before { controller.instance_variable_set(:@test, "Test")}
    let(:renderer) { Cynic::Renderer.new(path, controller) }
    
    it "assigns the cynic controllers instance methods" do
      expect(renderer.instance_variable_get(:@test)).to eq "Test"
    end
  end
end