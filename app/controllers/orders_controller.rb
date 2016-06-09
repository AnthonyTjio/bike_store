class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :constructor
  skip_before_filter  :verify_authenticity_token

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

  def payment
    
  end

  def deliver
    
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
    puts "XXXXXXXXXXXXXXXXXXXXXX"
    if(ok)
      puts "YYYYYYYYYYYYYYYYYYYYY"
      @order = Order.new()
      @order.status = 0
      puts @order.status
      puts "ZZZZZZZZZZZZZZZZZZZZZZZZ"
      @order.customer_id = @customer.id
      
      
      
      respond_to do |format|
        if @order.save
          format.json { render :show, status: :created, location: @order }
        else
          format.json {render json: {errors: @order.errors}, status: :unprocessable_entity }
        end
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
      params.require(:order).permit(:order_date, :status)
    end

    def customer_params
      params.require(:customer).permit(:id, :customer_name, :customer_address, :customer_phone)
    end  


    def update_customer_params
      params.require(:customer).permit(:id, :shipping_address, :customer_phone, :status)
    end  
end
