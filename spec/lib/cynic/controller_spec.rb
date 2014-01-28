require 'spec_helper'

class CynicController < Cynic::Controller
  def index
    @greeting = "hello"
    render :index
  end
end

describe Cynic::Controller do
  let(:controller) { CynicController.new }
  
  describe "#render" do
    it "finds a file" do
      Cynic::Renderer.any_instance.stub(:layout_file).and_return("<%= yield %>")
      File.should_receive(:read).with("app/views/cynic/index.html.erb").once.and_return('This is erb <%= "olleh".reverse %>')
      expect(controller.render(:index)).to eq "This is erb hello"
    end
    
    it "controller instance vars are available to the view" do
      Cynic::Renderer.any_instance.stub(:layout_file).and_return("<%= yield %>")
      File.should_receive(:read).with("app/views/cynic/index.html.erb").once.and_return('This is erb <%= @greeting %>')
      expect(controller.index).to eq "This is erb hello"
    end
    
    it "controller instance vars are available to the layout" do
      Cynic::Renderer.any_instance.stub(:layout_file).and_return("<%= @greeting %> <%= yield %>")
      File.should_receive(:read).with("app/views/cynic/index.html.erb").once.and_return('This is erb.')
      expect(controller.index).to eq "hello This is erb."
    end
    
  end
end