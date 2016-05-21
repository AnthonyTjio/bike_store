class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :constructor

  def constructor
    @status = ["Not Paid", "Paid", "Sent"]
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

  def payment
    @order = Order.find_by(id: params[:id])

    if(@order.set_paid==0)
      @order.status = "Paid"
      @order.save
      # temporary'

      @order = Order.find_by(id: params[:id])
      @order_lists = OrderItem.where(order_id: params[:id])

      @stocks = Array.new
      @stock_histories = Array.new
      @ok = 1

      @order_lists.each do |item|
        @stock = Stock.find_by(product_id: item.product_id)
        @stock_history = StockHistory.new

        @stock_history.stock_id = @stock.id
        @stock_history.alteration = item.qty
        @stock_history.description = "Purchased by "+@order.customer.customer_name+" on "+@order.created_at.to_s

        @stock.qty -= item.qty

        if(@stock.qty>=0)
          @stocks.push(@stock)
          @stock_histories.push(@stock_history)
        else
          @ok = 0
          break
        end
      end

      if(@ok==1)
        @stocks.each do |stock|
          stock.save
        end  
        @stock_histories.each do |stock_history|
          stock_history.save
        end
        @order.status = "Paid"
        @order.save
        redirect_to orders_path, notice: 'Paid'
      else
        redirect_to request_referer, notice: 'Insufficient stock'
      end
      # temporary
    end
  end

  def deliver
    @order = Order.find_by(id: params[:id])

    #if(@order.set_sent==0)
    
    if(@order.set_sent)
    # temporary'

      @order = Order.find_by(id: params[:id])
      @order_lists = OrderItem.where(order_id: params[:id])

      @stocks = Array.new
      @stock_histories = Array.new
      @ok = 1

      @order_lists.each do |item|
        @stock = Stock.find_by(product_id: item.product_id)
        @stock_history = StockHistory.new

        @stock_history.stock_id = @stock.id
        @stock_history.alteration = item.qty * -1
        @stock_history.description = "Purchased by "+@order.customer.customer_name+" on "+@order.created_at.to_s

        @stock.qty -= item.qty

        if(@stock.qty>=0)
          @stocks.push(@stock)
          @stock_histories.push(@stock_history)
        else
          @ok = 0
          break
        end
      end

      if(@ok==1)
        @stocks.each do |stock|
          stock.save
        end  
        @stock_histories.each do |stock_history|
          stock_history.save
        end
        @order.status = "Delivered"
        @order.save
        redirect_to orders_path, notice: 'Delivered'
      else
        redirect_to request_referer, notice: 'Insufficient stock'
      end
    # temporary
    end
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)
    @order.order_time = Time.new

    if(customer_params[:id]==nil||customer_params[:id]=='')
      @customer = Customer.new(customer_params)
      @customer.save
    else 
      @customer = Customer.find(customer_params[:id])
      @customer.update_attributes(customer_params)
    end

    @order.customer_id = @customer.id
    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        # format.html { redirect_to request.referer, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { redirect_to request.referer, notice: 'Insufficient stock'}
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    if(@order.set_paid==0)
      @order = Order.find_by(id: params[:id])
      
      @order.customer.shipping_address = update_customer_params[:shipping_address]
      @order.customer.customer_phone = update_customer_params[:customer_phone]
      @order.status = update_customer_params[:status]

      respond_to do |format|
        if @order.update_attributes(:status => update_customer_params[:status])
          @order.customer.update_attributes(
            :shipping_address => update_customer_params[:shipping_address], 
            :customer_phone => update_customer_params[:customer_phone])

          format.html { redirect_to @order, notice: 'Order was successfully updated.' }
          format.json { render :show, status: :ok, location: @order }
        else
          format.html { render :edit }
          format.json { render json: @order.errors, status: :unprocessable_entity }
        end
      end
    else
      if (@order.set_paid == 1) then redirect_to request.referer, :notice => "The order has paid already"
      else redirect_to request.referer, :notice => "The transaction has done"  end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
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
      params.require(:order).permit(:order_date, :order_time, :status)
    end

    def customer_params
      params.require(:customer).permit(:id, :customer_name, :customer_address, :shipping_address, :customer_phone)
    end  


    def update_customer_params
      params.require(:customer).permit(:id, :shipping_address, :customer_phone, :status)
    end  
end
