class HomeController < ApplicationController
  def catalog
    @filter = Proposals::Search.new(params)
    @proposals = @filter.results.page(params[:page])

    render :partial => 'proposals/table', :locals => { :proposals => @proposals } if wiselinks_partial_request?
  end

  def about
  end
end
