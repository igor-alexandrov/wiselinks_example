class Proposals::Search < Filter
  define_filter do
    method :title,        :type => :string
    method :description,  :type => :string
    method :category,     :type => :string
    method :country,      :type => :string
    method :price,        :type => :integer
  end

  protected

  def scope
    Proposal
  end
end