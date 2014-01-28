require 'spec_helper'

describe Cynic::Renderer do
  path = "cynic/controller/index.html.erb"
  let(:renderer) { Cynic::Renderer.new(path) }
  
  describe "#render" do
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
end