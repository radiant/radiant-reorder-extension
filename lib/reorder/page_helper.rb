module Reorder::PageHelper
  def order_links(page)
    String.new.tap do |output|
      %w{move_to_top move_higher move_lower move_to_bottom}.each do |action|
        output << link_to(image("#{action}.png", :alt => action.humanize), 
                          self.send("page_#{action}_url", :id => page), 
                          :method => :post)
      end
    end
  end
end
