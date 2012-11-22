class Proposal < ActiveRecord::Base
  attr_accessible :title, :description, :country, :category, :price
end
