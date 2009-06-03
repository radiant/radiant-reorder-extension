require File.dirname(__FILE__) + '/../spec_helper'

describe Admin::PagesController do
  dataset :users, :pages_with_positions

  before do
    login_as :existing
    @page = pages(:documentation)
  end

  it "should move higher" do
    lambda {
      post :move_higher, :id => @page.id
      @page.reload
    }.should change(@page, :position).by -1
  end

  it "should move lower" do
    lambda {
      post :move_lower, :id => @page.id
      @page.reload
    }.should change(@page, :position).by 1
  end

  it "should move to top" do
    post :move_to_top, :id => @page.id
    @page.reload
    @page.position.should eql(1)
  end

  it "should move to bottom" do
    post :move_to_bottom, :id => @page.id
    @page.reload
    @page.position.should == @page.parent.children.size
  end

  it "should require login" do
    logout
    %w{move_higher move_lower move_to_top move_to_bottom}.each do |action|
      post action, :id => @page.id
      response.should redirect_to(login_url)
    end
  end

end