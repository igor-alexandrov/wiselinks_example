class Proposals::Search < Filter
  define_filter do
    method :title,  :type => :string
    method :brand,  :type => :string
    method :rating, :type => :integer
    method :price,  :type => :integer
  end

  protected

  def scope
    Proposal
  end
end