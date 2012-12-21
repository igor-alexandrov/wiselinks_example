class HomeController < ApplicationController
  def catalog
    @filter = Proposals::Search.new(params)    

    render :partial => 'proposals/table', :locals => { :proposals => @filter.results } if request.wiselinks_partial?
  end

  def about
  end
end
