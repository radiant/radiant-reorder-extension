require File.dirname(__FILE__) + "/../test_helper"

class PageExtensionsTest < Test::Unit::TestCase
  dataset :pages_with_positions
  
  def setup
    @page = Page.new
    @pages = pages(:home).children
  end

  def test_should_add_acts_as_list_methods
    [:position, :move_higher, :move_lower, :move_to_top, :move_to_bottom].each do |m|
      assert_respond_to @page, m
    end
  end
  
  def test_should_reorder_children_by_position
    assert_equal "position ASC", Page.reflections[:children].options[:order]
  end
  
  def test_should_scope_list_to_parent_id
    assert_respond_to @page, :scope_condition
    assert_equal "parent_id IS NULL", @page.scope_condition
    @page.parent_id = 2
    assert_equal "parent_id = 2", @page.scope_condition
  end
  
  def test_should_return_children_in_position_order
    assert_equal pages(:home).children, pages(:home).children.sort_by(&:position)
  end
  
  def test_should_swap_with_top_when_next_to_top
    assert_equal [[1, "Page A"], [2, "Documentation"]], order_map(@pages.to_a)[0..1]
    @page = pages(:documentation)
    @page.move_higher
    @pages.reload
    assert_equal [[1, "Documentation"], [2, "Page A"]], order_map(@pages.to_a)[0..1]
    assert @pages[1..-1].all?{|p| p.position.to_i != 1}
  end

  def test_should_swap_with_top_when_next_to_top_and_moving_to_top
    assert_equal [[1, "Page A"], [2, "Documentation"]], order_map(@pages.to_a)[0..1]
    @page = pages(:documentation)
    @page.move_to_top
    @pages.reload
    assert_equal [[1, "Documentation"], [2, "Page A"]], order_map(@pages.to_a)[0..1]
    assert @pages[1..-1].all?{|p| p.position.to_i != 1}
  end

  def test_should_swap_with_bottom_when_next_to_bottom
    assert_equal [[5, "Page Y"], [6, "Page Z"]], order_map(@pages.to_a)[-2..-1]
    @page = pages(:page_y)
    @page.move_lower
    @pages.reload
    assert_equal [[5, "Page Z"], [6, "Page Y"]], order_map(@pages.to_a)[-2..-1]
    assert @pages[0..-2].all?{|p| p.position.to_i != 6}
  end

  def test_should_swap_with_bottom_when_next_to_bottom_and_moving_to_bottom
    assert_equal [[5, "Page Y"], [6, "Page Z"]], order_map(@pages.to_a)[-2..-1]
    @page = pages(:page_y)
    @page.move_to_bottom
    @pages.reload
    assert_equal [[5, "Page Z"], [6, "Page Y"]], order_map(@pages.to_a)[-2..-1]
    assert @pages[0..-2].all?{|p| p.position.to_i != 6}
  end
  
  private
    def order_map(coll)
      coll.map {|r| [r.position, r.title]}
    end
end
