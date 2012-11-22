class HomeController < ApplicationController
  def catalog
    @proposals = Proposal.all
  end

  def about
  end
end
