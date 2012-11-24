class HomeController < ApplicationController
  def catalog
    @proposals = Proposals::Search.new(params).results.paginate(:page => params[:page], :per_page => 10)
  end

  def about
  end
end
