class AddPositionToPages < ActiveRecord::Migration
  def self.up
    add_column :pages, :position, :integer
    Page.reset_column_information
    say_with_time("Putting all pages in a default order...") do
      Page.find_all_by_parent_id(nil).each do |p|
        put_children_into_list(p)
      end
    end
  end
  
  def self.down
    remove_column :pages, :position
  end
  
  def self.put_children_into_list(page)
    page.children.find(:all, :order => "title asc").each_with_index do |pg, idx|
      pg.position = idx + 1
      pg.save
      put_children_into_list(pg)
    end
  end
end
