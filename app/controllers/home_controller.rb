class HomeController < ApplicationController
  def index
  end

  def redirect
    redirect_to catalog_url
  end

  def catalog 
    @filter = Proposals::Search.new(params)    

    render :partial => 'proposals/table', :locals => { :proposals => @filter.results } if request.wiselinks_partial?    
  end
end
