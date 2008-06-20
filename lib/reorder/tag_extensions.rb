module Reorder::TagExtensions
  def self.included(base)
    base.class_eval { alias_method_chain :children_find_options, :reorder }
  end
  
  def children_find_options_with_reorder(tag)
    options = children_find_options_without_reorder(tag)
    options[:order].sub!(/published_at/i, 'position') unless tag.attr['by']
    options
  end
end
