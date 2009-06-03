require File.dirname(__FILE__) + '/../spec_helper'
require 'ostruct'

describe Reorder::TagExtensions do
  before do
    @tag = OpenStruct.new
    @tag.attr = { :status => 'all' }
    @children_find_options = Page.new.method(:children_find_options)
  end
  
  it "should override default options" do
    opts = @children_find_options.call(@tag)
    opts[:order].should match(/position/)
  end
  
  it "should not override when 'by' is specified" do
    @tag.attr['by'] = "created_at"
    opts = @children_find_options.call(@tag)
    opts[:order].should_not match(/position/)
  end

  it "should be independent of order attributes" do
    @tag.attr['order'] = 'desc'
    opts = @children_find_options.call(@tag)
    opts[:order].should match(/position/)
  end
end