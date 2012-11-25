class HomeController < ApplicationController
  def catalog
    @filter = Proposals::Search.new(params)
    @proposals = @filter.results.page(params[:page])
  end

  def about
  end
end
