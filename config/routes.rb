ActionController::Routing::Routes.draw do |map|
  map.with_options :controller => "admin/pages" do |page|
    page.page_move_lower "admin/pages/:id/move_lower", :action => "move_lower"
    page.page_move_higher "admin/pages/:id/move_higher", :action => "move_higher"
    page.page_move_to_bottom "admin/pages/:id/move_to_bottom", :action => "move_to_bottom"
    page.page_move_to_top "admin/pages/:id/move_to_top", :action => "move_to_top"
  end
end