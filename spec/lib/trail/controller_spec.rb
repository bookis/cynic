require 'spec_helper'

describe Trail::Controller do
  let(:controller) { Trail::Controller.new }
  
  describe "#render" do
    it "finds a file" do
      Trail::Renderer.any_instance.stub(:layout_file).and_return("<%= yield %>")
      File.should_receive(:read).with("views/trail/controller/index.html.erb").once.and_return('This is erb <%= "olleh".reverse %>')
      expect(controller.render(:index)).to eq "This is erb hello"
    end
  end
end