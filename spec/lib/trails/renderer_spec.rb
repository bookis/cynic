require 'spec_helper'

describe Trails::Renderer do
  path = "trail/controller/index.html.erb"
  let(:renderer) { Trails::Renderer.new(path) }
  
  describe "#render" do
    it "finds a file" do
      File.should_receive(:read).with("views/" + path).and_return('This is erb <%= "olleh".reverse %>')
      expect(renderer.body).to eq "This is erb hello"
    end
    
    it "finds a file with a layout" do
      Trails::Renderer.any_instance.stub(:layout_file).and_return("Layout: <%= yield %> :file" )
      File.should_receive(:read).with("views/" + path).and_return('This is erb <%= "olleh".reverse %>')
      expect(renderer.body).to eq "Layout: This is erb hello :file"
    end
    
  end
end