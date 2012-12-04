class HomeController < ApplicationController
  def catalog
    @filter = Proposals::Search.new(params)    

    render :partial => 'proposals/table', :locals => { :proposals => @filter.results } if wiselinks_partial_request?
  end

  def about
  end
end
