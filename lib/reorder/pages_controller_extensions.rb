module Reorder::PagesControllerExtensions

  %w{move_higher move_lower move_to_top move_to_bottom}.each do |action|
    define_method action do
      @page = Page.find(params[:id])
      @page.parent.reload.children.reload
      @page.send(action)
      response_for :update
    end
  end
  
end
