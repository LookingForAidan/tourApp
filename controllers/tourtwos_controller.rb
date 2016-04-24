require 'tourtwo_decorator'
require 'my_logger'
class TourtwosController < ApplicationController
   before_filter :authenticate_user! 
  before_filter :ensure_admin, 
  :only => [:edit, :destroy]
  before_action :set_tourtwo, only: [:show, :edit, :update, :destroy]

  # GET /tourtwos
  # GET /tourtwos.json
  def index
    @tourtwos = Tourtwo.all
    if params[:search]
      @tourtwos = Tourtwo.search(params[:search]).order("created_at DESC")
    else
      @tourtwos = Tourtwo.all.order('created_at DESC')
    end
  end

  # GET /tourtwos/1
  # GET /tourtwos/1.json
  def show
  end



  def ensure_admin

    unless current_user && current_user.admin?

    render :text => "Access Error Message", :status => :unauthorized

    end
  end

  # GET /tourtwos/new
  def new
    @tourtwo = Tourtwo.new
  end

  # GET /tourtwos/1/edit
  def edit
  end

  # POST /tourtwos
  # POST /tourtwos.json
  def create
    @tourtwo = Tourtwo.new()
    @tourtwo.fname = params[:tourtwo][:fname]
    @tourtwo.lname = params[:tourtwo][:lname]
    @tourtwo.email = params[:tourtwo][:email]
    @tourtwo.date = params[:tourtwo][:date]
    
    myTourtwo = BasicTourtwo.new(20)
    if params[:tourtwo][:life].to_s.length > 0 
      then myTourtwo = LifeDecorator.new(myTourtwo)
    end
    if params[:tourtwo][:howth].to_s.length > 0 
      then myTourtwo = HowthDecorator.new(myTourtwo)
    end
 
    
    @tourtwo.cost = myTourtwo.cost
    @tourtwo.description = myTourtwo.details
    @tourtwo.date = myTourtwo.details
   
    logger = MyLogger.instance
    logger.logInformation("A new Boat tour guide was requested: " + @tourtwo.description)

    respond_to do |format|
      if @tourtwo.save
        format.html { redirect_to @tourtwo, notice: 'Tourtwo was successfully created.' }
        format.json { render :show, status: :created, location: @tourtwo }
      else
        format.html { render :new }
        format.json { render json: @tourtwo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tourtwos/1
  # PATCH/PUT /tourtwos/1.json
  def update
    respond_to do |format|
      if @tourtwo.update(tourtwo_params)
        format.html { redirect_to @tourtwo, notice: 'Tourtwo was successfully updated.' }
        format.json { render :show, status: :ok, location: @tourtwo }
      else
        format.html { render :edit }
        format.json { render json: @tourtwo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tourtwos/1
  # DELETE /tourtwos/1.json
  def destroy
    @tourtwo.destroy
    respond_to do |format|
      format.html { redirect_to tourtwos_url, notice: 'Tourtwo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tourtwo
      @tourtwo = Tourtwo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tourtwo_params
      params.require(:tourtwo).permit(:fname, :lname, :email, :description, :date, :cost)
    end
end
