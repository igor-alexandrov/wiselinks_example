class HomeController < ApplicationController
  def catalog
    @proposals = Proposals::Search.new(params).results
  end

  def about
  end
end
