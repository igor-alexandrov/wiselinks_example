module ApplicationHelper
  def set_title(value)
    content_for(:title, value)

    # wiselinks_title(value) 
  end
end
