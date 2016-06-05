class StockHistory < ActiveRecord::Base  
  belongs_to :stock
  attr_accessor :product, :type, :start_date, :end_date
  validates_presence_of :stock_id, :alteration, :description
  validate :alteration_validation

  def alteration_validation
  	if alteration.zero?
  		errors.add(:alteration, "cannot be 0")
  	end
  end
end
