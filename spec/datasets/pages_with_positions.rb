class PagesWithPositionsDataset < Dataset::Base
  uses :home_page
  
  def load
    create_page "Documentation", :position => 2
    create_page "Page A", :position => 1
    create_page "Page B", :position => 3
    create_page "Page C", :position => 4
    create_page "Page Y", :position => 5
    create_page "Page Z", :position => 6
  end
  
  helpers do
    def order_map(coll)
      coll.map {|r| [r.position, r.title]}
    end
  end
end
