require 'tour_decorator'
require 'my_logger'
class ToursController < ApplicationController
before_filter :authenticate_user! 
  before_filter :ensure_admin, 
  :only => [:edit, :destroy]

  before_action :set_tour, only: [:show, :edit, :update, :destroy]

  # GET /tours
  # GET /tours.json
  def index
    @tours = Tour.all
    if params[:search]
      @tours = Tour.search(params[:search]).order("created_at DESC")
    else
      @tours = Tour.all.order('created_at DESC')
    end
  end

  # GET /tours/1
  # GET /tours/1.json
  def show
  end

  # GET /tours/new
  def new
    @tour = Tour.new
  end

  # GET /tours/1/edit
  def edit
  end

  # POST /tours
  # POST /tours.json
  def create
    @tour = Tour.new()
    @tour.fname = params[:tour][:fname]
    @tour.lname = params[:tour][:lname]
    @tour.email = params[:tour][:email]
    @tour.date = params[:tour][:date]
    
    myTour = BasicTour.new(20)
    if params[:tour][:audio].to_s.length > 0 
      then myTour = AudioDecorator.new(myTour)
    end
    if params[:tour][:lunch].to_s.length > 0 
      then myTour = LunchDecorator.new(myTour)
    end
    if params[:tour][:discount].to_s.length > 0 
      then myTour = OAPDecorator.new(myTour)
    end
    
    @tour.cost = myTour.cost
    @tour.description = myTour.details
    @tour.date = myTour.details
   
    logger = MyLogger.instance
    logger.logInformation("A new tour guide was requested: " + @tour.description)

    respond_to do |format|
      if @tour.save
        format.html { redirect_to @tour, notice: 'Tour was successfully created.' }
        format.json { render :show, status: :created, location: @tour }
      else
        format.html { render :new }
        format.json { render json: @tour.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tours/1
  # PATCH/PUT /tours/1.json
  def update
    

@tour.fname = params[:tour][:fname]
@tour.lname = params[:tour][:lname]
@tour.email = params[:tour][:email]
@tour.date = params[:tour][:date]

myTour = BasicTour.new(20)

if params[:tour][:audio].to_s.length > 0 
  then myTour = AudioDecorator.new(myTour)
end

if params[:tour][:lunch].to_s.length > 0 
  then myTour = LunchDecorator.new(myTour)
end

if params[:tour][:discount].to_s.length > 0 
  then myTour = OAPDecorator.new(myTour)
end
    
    
  @tour.cost = myTour.cost

  @tour.description = myTour.details

# build a hash with the updated information of the car 
    updated_information = {
      "fname" => @tour.fname,
      "lname" => @tour.lname,
      "cost" => @tour.cost,
      "description" => @tour.description,
      "date" => @tour.date
    }
    
    respond_to do |format|
      if @tour.update(tour_params)
        format.html { redirect_to @tour, notice: 'Tour was successfully updated.' }
        format.json { render :show, status: :ok, location: @tour }
      else
        format.html { render :edit }
        format.json { render json: @tour.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tours/1
  # DELETE /tours/1.json
  def destroy
    @tour.destroy
    respond_to do |format|
      format.html { redirect_to tours_url, notice: 'Tour was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  def ensure_admin

    unless current_user && current_user.admin?

    render :text => "Access Error Message", :status => :unauthorized

    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tour
      @tour = Tour.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tour_params
      params.require(:tour).permit(:fname, :lname, :email, :description, :date, :cost)
    end
end
