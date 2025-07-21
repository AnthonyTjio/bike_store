class KucingsController < ApplicationController
  before_action :kucing_params, only: [:show, :edit, :update, :destroy]

  # GET /kucings
  # GET /kucings.json
  def index
    @kucings = Kucing.all
  end
  
  def tikus
    
  end

  # GET /kucings/1
  # GET /kucings/1.json
  def show
  end

  # GET /kucings/new
  def new
    @kucing = Kucing.new
  end

  # GET /kucings/1/edit
  def edit
  end

  # POST /kucings
  # POST /kucings.json
  def create
    @kucing = Kucing.new(kucing_params)

    respond_to do |format|
      if @kucing.save
        format.html { redirect_to @kucing, notice: 'Kucing was successfully created.' }
        format.json { render :show, status: :created, location: @kucing }
      else
        format.html { render :new }
        format.json { render json: @kucing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /kucings/1
  # PATCH/PUT /kucings/1.json
  def update
    respond_to do |format|
      if @kucing.update(kucing_params)
        format.html { redirect_to @kucing, notice: 'Kucing was successfully updated.' }
        format.json { render :show, status: :ok, location: @kucing }
      else
        format.html { render :edit }
        format.json { render json: @kucing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /kucings/1
  # DELETE /kucings/1.json
  def destroy
    @kucing.destroy
    respond_to do |format|
      format.html { redirect_to kucings_url, notice: 'Kucing was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_kucing
      @kucing = Kucing.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def kucing_params
      params.fetch(:kucing, {})
    end
end
