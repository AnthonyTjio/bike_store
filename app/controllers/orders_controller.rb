class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :constructor

  skip_before_filter :verify_authenticity_token
  
  def constructor
    
  end

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @order_items = OrderItem.where(order_id: @order.id)
  end

  # GET /orders/new
  def new
    @order = Order.new
    @customer = Customer.new
  end

  # GET /orders/1/edit
  def edit
    @customer = Customer.find_by(id: @order.customer_id)
  end

  def verify_order
    @order = Order.find(order_params[:id])
    @order_items = OrderItem.where(:order_id => @order.id)

    if @order_items.nil? # cart is empty
      respond_to do |format|
          format.json { render json: {message: "The shopping cart is empty, please put some before proceeding"}, status: :unprocessable_entity }
      end
    else  #cart is not empty
      verified = true
      @order_items.each do |item| # check whether all items are available
        checked_product = Product.find_by_id(item.product_id)
        checked_stock = Stock.find_by(product_id: checked_product.id)            

        if checked_stock.qty < item.qty # if the stock is insufficient
          verified = false # then we cannot proceed the checkout
        end

      end # end of checking

      if verified # if all stock is available
        @order.status = 1

        @order_items.each do |item| # remake tapi udah jalan
          checked_product = Product.find_by_id(item.product_id)
          checked_stock = Stock.find_by(product_id: checked_product.id)        

          # Creates Documentation
          stock_history = StockHistory.new
          stock_history.stock_id = checked_stock.id
          stock_history.alteration = item.qty
          stock_history.description = "Ordered by "+@order.customer.customer_name+" on order #"+@order.id

          # Edit Current Stock
          checked_stock.qty = checked_stock.qty - item.qty

          # Save changes
          stock_history.save
          checked_stock.save 
        end #

        @order.save
        respond_to do |format|
          format.json { render json: {message: "The order is being processed"}, status: :success }
        end

      else # one or more stock is short on stock
        respond_to do |format|
          format.json { render json: {message: "One or more bikes in the cart is unsufficient" }, status: :unprocessable_entity }
        end
      end

    end
    
  end

  def confirm_payment
    
  end

  def confirm_deliver
    
  end

  # POST /orders
  # POST /orders.json
  def create
     ok = true
     @customer = Customer.find_by_id(customer_params[:id])
     if(@customer==nil)
        respond_to do |format|
          format.json { render json: {errors: "Customer not found"}, status: :unprocessable_entity }
        end
    end
    puts "TEST"
    if(ok)
      @order = Order.new()
      @order.customer_id = @customer.id
      
      respond_to do |format|
        if @order.save
          puts "Success"
          format.json { render :show, status: :created, location: @order }
        else
          puts "Failed"
          format.json {render json: {errors: @order.errors}, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    @order = Order.find_by_id(order_params[:id])
    if(@order.update(order_params))
      # specify what you're going to do if the updated order has "this"
    else
      respond_to do |format|
        format.json {render json: {errors: @order.errors}, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.cancel_order
    
    @order.update
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:id, :order_date, :is_paid, :payment_date, :is_delivered,:shipping_address, :shipping_method, :shipping_date, :receipt_number,)
    end

    def customer_params
      params.require(:customer).permit(:id, :customer_name, :customer_address, :customer_phone)
    end  

end
