# Uncomment this if you reference any of your controllers in activate
require_dependency 'application_controller'

class ReorderExtension < Radiant::Extension
  version "0.2.1"
  description "Allows (re)ordering of pages in the page tree."
  url "http://dev.radiantcms.org/"
  
  define_routes do |map|
    map.with_options :controller => "admin/pages" do |page|
      page.page_move_lower "admin/pages/:id/move_lower", :action => "move_lower"
      page.page_move_higher "admin/pages/:id/move_higher", :action => "move_higher"
      page.page_move_to_bottom "admin/pages/:id/move_to_bottom", :action => "move_to_bottom"
      page.page_move_to_top "admin/pages/:id/move_to_top", :action => "move_to_top"
    end
  end
  
  def activate
    admin.page.index.add :sitemap_head, "order_header"
    admin.page.index.add :node, "order"
    admin.page.index.add :top, 'header'
    Page.send :include, Reorder::PageExtensions
    Admin::PagesController.send :include, Reorder::PagesControllerExtensions
    Admin::PagesController.send :helper, Reorder::PageHelper
    StandardTags.send :include, Reorder::TagExtensions
  end
end
