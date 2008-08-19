module Reorder::PageExtensions
  def self.included(base)
    base.class_eval {
      acts_as_list :scope => :parent_id
      self.reflections[:children].options[:order] = "position ASC"
    }
    
    if defined?(Page::NONDRAFT_FIELDS)
      Page::NONDRAFT_FIELDS << 'position'
    end
  end
end
