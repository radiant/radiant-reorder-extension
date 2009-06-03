require File.dirname(__FILE__) + '/../spec_helper'

describe Reorder::PageExtensions do
  dataset :pages_with_positions

  before do
    @page = Page.new
    @pages = pages(:home).children
  end

  it "should add acts as list methods" do
    [:position, :move_higher, :move_lower, :move_to_top, :move_to_bottom].each do |m|
      @page.should respond_to(m)
    end
  end

  it "should reorder children by position" do
    Page.reflections[:children].options[:order].should eql("position ASC")
  end

  it "should scope list to parent id" do
    @page.should respond_to(:scope_condition)
    @page.scope_condition.should eql("parent_id IS NULL")
    @page.parent_id = 2
    @page.scope_condition.should eql("parent_id = 2")
  end

  it "should return children in position order" do
    pages(:home).children.sort_by(&:position).should == pages(:home).children
  end

  it "should swap with top when next to top" do
    order_map(@pages.to_a)[0..1].should == [[1, "Page A"], [2, "Documentation"]]
    @page = pages(:documentation)
    @page.move_higher
    @pages.reload
    order_map(@pages.to_a)[0..1].should == [[1, "Documentation"], [2, "Page A"]]
    @pages[1..-1].all? {|p| p.position.to_i != 1}.should be_true
  end

  it "should swap with top when next to top and moving to top" do
    order_map(@pages.to_a)[0..1].should == [[1, "Page A"], [2, "Documentation"]]
    @page = pages(:documentation)
    @page.move_to_top
    @pages.reload
    order_map(@pages.to_a)[0..1].should == [[1, "Documentation"], [2, "Page A"]]
    @pages[1..-1].all? {|p| p.position.to_i != 1}.should be_true
  end

  it "should swap with bottom when next to bottom" do
    order_map(@pages.to_a)[-2..-1].should == [[5, "Page Y"], [6, "Page Z"]]
    @page = pages(:page_y)
    @page.move_lower
    @pages.reload
    order_map(@pages.to_a)[-2..-1].should == [[5, "Page Z"], [6, "Page Y"]]
    @pages[0..-2].all? {|p| p.position.to_i != 6}.should be_true
  end

  it "should swap with bottom when next to bottom and moving to bottom" do
    order_map(@pages.to_a)[-2..-1].should == [[5, "Page Y"], [6, "Page Z"]]
    @page = pages(:page_y)
    @page.move_to_bottom
    @pages.reload
    order_map(@pages.to_a)[-2..-1].should == [[5, "Page Z"], [6, "Page Y"]]
    @pages[0..-2].all? {|p| p.position.to_i != 6}.should be_true
  end
end