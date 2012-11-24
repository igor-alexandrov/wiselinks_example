require 'open-uri'

class Parsers::AmazonParser

  attr_accessor :url
  attr_reader :doc

  def initialize(url)
    @url = url
    @doc = Nokogiri::HTML(open(@url))
  end

  def parse
    items = @doc.xpath('//*[@class="zg_item_normal"]')

    items.each do |item| 
      parse_item(item)
    end
  end

  protected

  def parse_item(item)
    proposal = Proposal.new

    proposal.title      = self.parse_title(item)
    proposal.brand      = self.parse_brand(item)
    proposal.rating     = self.parse_rating(item)
    proposal.price      = self.parse_price(item)
    proposal.image_url  = self.parse_image_url(item)

    proposal.save!
    proposal
  end

  # Parsing attributes

  def parse_title(item)
    title_item = item.xpath('.//*[@class="zg_title"]').first
    title_item.content if title_item.present?
  end

  def parse_brand(item)
    brand_item = item.xpath('.//*[@class="zg_byline"]').first
    brand_item.content.gsub(/^by /, '') if brand_item.present?
  end

  def parse_rating(item)
    rating_item = item.xpath('.//*[@class="asinReviewsSummary acr-popover"]/*[1]//*[contains(@class, "swSprite")]/@title').first
    rating_item.content.to_f if rating_item.present?
  end

  def parse_price(item)
    price_item = item.xpath('.//*[@class="priceBlock"]/strong[text()="Price: "]/../*[@class="price"]').first
    price_item.content.delete('$') if price_item.present?
  end

  def parse_image_url(item)
    image_url_item = item.xpath('.//*[@class="zg_itemImage_normal"]//img/@src').first
    image_url_item.content if image_url_item.present?
  end
end