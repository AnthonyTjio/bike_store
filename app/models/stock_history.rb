class StockHistory < ActiveRecord::Base  
  belongs_to :stock
  attr_accessor :product, :type
  validates_presence_of :stock_id, :alteration
end
