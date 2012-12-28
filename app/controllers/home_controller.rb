class HomeController < ApplicationController
  def catalog
    @filter = Proposals::Search.new(params)    

    render :partial => 'proposals/table', :locals => { :proposals => @filter.results } if request.wiselinks_partial?
    # response.headers['X-Wiselinks-Redirect'] = root_url
    # redirect_to root_path
  end

  def about
  end
end
