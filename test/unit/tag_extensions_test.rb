require File.dirname(__FILE__) + "/../test_helper"
require 'ostruct'

class TagExtensionsTest < Test::Unit::TestCase
  def setup
    @tag = OpenStruct.new
    @tag.attr = { :status => 'all' }
    @children_find_options = Page.new.method(:children_find_options)
  end
  
  def test_should_override_default_options
    opts = @children_find_options.call(@tag)
    assert_match /position/, opts[:order]
  end
  
  def test_should_not_override_when_by_is_specified
    @tag.attr['by'] = "created_at"
    opts = @children_find_options.call(@tag)
    assert_no_match /position/, opts[:order]
  end
  
  def test_should_be_independent_of_order_attribute
    @tag.attr['order'] = 'desc'
    opts = @children_find_options.call(@tag)
    assert_match /position/, opts[:order]    
  end
end
