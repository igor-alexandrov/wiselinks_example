class Proposals::Search < Filter
  define_filter do
    method :title,      :type => :string
    method :brand,      :type => :string

    method :rating_min, :type => :float
    method :rating_max, :type => :float

    method :price_min,  :type => :float
    method :price_max,  :type => :float
  end

  protected

  def scope
    Proposal
  end

  def filter_title
    { :title.like => "%#{title}%" } if title.present?
  end

  def filter_rating_min
    { :rating.gteq => rating_min } if rating_min.present?
  end

  def filter_rating_max
    { :rating.lteq => rating_max } if rating_max.present?
  end

  def filter_price_min
    { :price.gteq => price_min } if price_min.present?
  end

  def filter_price_max
    { :price.lteq => price_max } if price_max.present?
  end
end