require File.dirname(__FILE__) + '/../test_helper'

class ReorderExtensionTest < Test::Unit::TestCase
  
  
  def test_initialization
    assert_equal File.join(File.expand_path(RAILS_ROOT), 'vendor', 'extensions', 'reorder'), ReorderExtension.root
    assert_equal 'Reorder', ReorderExtension.extension_name
  end
  
end
