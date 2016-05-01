class StockHistory < ActiveRecord::Base
  belongs_to :stock
  def product
    #stock =Stock.find_by(id: [stock_id])
    #puts "================================================="
    #puts [:id]
    #puts "================================================="
  	#Product.find_by(id: stock.product_id)#Stock.find_by(id: stock_id).product_id )
    #rescue
    # Product.find_by(id: 53)
  end

  def product=(product_id)
  	stock_id = Stock.find_by(product_id: product_id)
  end

  def type
  	
  end

  def type=(history_type)

  end	
end
