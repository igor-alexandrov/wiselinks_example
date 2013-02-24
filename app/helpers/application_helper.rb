module ApplicationHelper
  def set_title(value)
    content_for(:title, value)

    wiselinks_title(value) 
  end

  def wiselinks_version    
    Gem.loaded_specs['wiselinks'].version.to_s rescue nil
  end
end
