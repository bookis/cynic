require 'spec_helper'

class CynicController < Cynic::Controller
  def index
    @greeting = "hello"
    render :template
  end
  
  def do_i_live_in_a_tub?
    @answer = "not yet"
  end
end

describe Cynic::Controller do
  let(:controller) { CynicController.new }
  let(:env) { {"REQUEST_METHOD" => "GET", "REQUEST_PATH" => "/cynic", "rack.input" => "wtf", "QUERY_STRING" => "id=1",  "CONTENT_TYPE" => "text/json"} }
  
  before { CynicController.instance_variable_set(:@before_actions, nil)}
  
  describe "#request" do
    before { 
      request = Rack::Request.new(env)
      controller.request = request
    }
    it "has params" do
      expect(controller.params[:id]).to eq "1"
    end
  end
  describe "#render" do
    it "finds a file" do
      Cynic::Renderer.any_instance.stub(:layout_file).and_return("<%= yield %>")
      File.should_receive(:read).with("app/views/cynic/index.html.erb").once.and_return('This is erb <%= "olleh".reverse %>')
      expect(controller.render(:index)).to eq "This is erb hello"
    end
    
    it "controller instance vars are available to the view" do
      Cynic::Renderer.any_instance.stub(:layout_file).and_return("<%= yield %>")
      File.should_receive(:read).with("app/views/cynic/template.html.erb").once.and_return('This is erb <%= @greeting %>')
      expect(controller.index).to eq "This is erb hello"
    end
    
    it "controller instance vars are available to the layout" do
      Cynic::Renderer.any_instance.stub(:layout_file).and_return("<%= @greeting %> <%= yield %>")
      File.should_receive(:read).with("app/views/cynic/template.html.erb").once.and_return('This is erb.')
      expect(controller.index).to eq "hello This is erb."
    end
  end
  
  describe ".before_action" do
    it "responds to" do
      expect(CynicController.respond_to?(:before_action)).to be_true
    end
    
    it "assigns each of the things to an array" do
      CynicController.before_action :do_i_live_in_a_tub?
      expect(CynicController.before_actions[:all]).to include :do_i_live_in_a_tub?
    end
    
    context ":all" do
      it "calls each before action within :all" do
        CynicController.before_action :do_i_live_in_a_tub?
        File.should_receive(:read).with("app/views/cynic/template.html.erb").once.and_return('This is erb.')
        controller.should_receive(:do_i_live_in_a_tub?).once.and_return(true)
        controller.response(:index)
      end
    
      it "can use a instance var defined in a before action" do
        CynicController.before_action :do_i_live_in_a_tub?
        File.should_receive(:read).with("app/views/cynic/template.html.erb").once.and_return('Do I live in a tub? <%= @answer %>.')
        expect(controller.response(:index)).to eq 'Do I live in a tub? not yet.'
      end
    end
    
    context "when using the :only option" do
      it "assigns the action name it should be nested under" do
        CynicController.before_action :do_i_live_in_a_tub?, only: :show
        expect(CynicController.before_actions[:show]).to include :do_i_live_in_a_tub?
      end

      it "assigns the action names it should be nested under" do
        CynicController.before_action :do_i_live_in_a_tub?, only: [:show]
        expect(CynicController.before_actions[:show]).to include :do_i_live_in_a_tub?
      end
      
      it "calls each before action within :all" do
        CynicController.before_action :do_i_live_in_a_tub?, only: :index
        File.should_receive(:read).with("app/views/cynic/template.html.erb").once.and_return('This is erb.')
        controller.should_receive(:do_i_live_in_a_tub?).once.and_return(true)
        controller.response(:index)
      end
    end
  end
end