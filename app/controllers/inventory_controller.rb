class InventoryController < ApplicationController
    
  def index
  	@products = Product.all
  end

  def add
    @products = Product.all
  	@stock = Stock.new
  	@stock_history = StockHistory.new
  end

  def check
  	@product = Product.find(params[:id])
  	@stock = Stock.find_by(product_id: @product.id)
  	@stock_histories = StockHistory.where(stock_id: @stock.id)
  end

  def revise
    @products = Product.all
    @stock = Stock.new
    @stock_history = StockHistory.new
  end

end
