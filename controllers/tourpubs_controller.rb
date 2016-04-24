
class TourpubsController < ApplicationController
  before_action :set_tourpub, only: [:show, :edit, :update, :destroy]

  # GET /tourpubs
  # GET /tourpubs.json
  def index
    @tourpubs = Tourpub.all
  end

  # GET /tourpubs/1
  # GET /tourpubs/1.json
  def show
  end

  # GET /tourpubs/new
  def new
    @tourpub = Tourpub.new
  end

  # GET /tourpubs/1/edit
  def edit
  end

  # POST /tourpubs
  # POST /tourpubs.json
  def create
    @tourpub = Tourpub.new()
    @tourpub.fname = params[:tourpub][:fname]
    @tourpub.lname = params[:tourpub][:lname]
    @tourpub.email = params[:tourpub][:email]
    @tourpub.date = params[:tourpub][:date]
    
    myTourpub = BasicTourpub.new(35)
    if params[:tourpub][:cider].to_s.length > 0 
      then myTourpub = CiderDecorator.new(myTourpub)
    end
    if params[:tourpub][:craft].to_s.length > 0 
      then myTourpub = CraftDecorator.new(myTourpub)
    end

    
    @tourpub.cost = myTourpub.cost
    @tourpub.description = myTourpub.details
    @tourpub.date = myTourpub.details
   
    logger = MyLogger.instance
    logger.logInformation("A new pub crawl was requested: " + @Tourpub.description)

    respond_to do |format|
      if @tourpub.save
        format.html { redirect_to @tourpub, notice: 'Tourpub was successfully created.' }
        format.json { render :show, status: :created, location: @tourpub }
      else
        format.html { render :new }
        format.json { render json: @tourpub.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tourpubs/1
  # PATCH/PUT /tourpubs/1.json
  def update
    respond_to do |format|
      if @tourpub.update(tourpub_params)
        format.html { redirect_to @tourpub, notice: 'Tourpub was successfully updated.' }
        format.json { render :show, status: :ok, location: @tourpub }
      else
        format.html { render :edit }
        format.json { render json: @tourpub.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tourpubs/1
  # DELETE /tourpubs/1.json
  def destroy
    @tourpub.destroy
    respond_to do |format|
      format.html { redirect_to tourpubs_url, notice: 'Tourpub was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tourpub
      @tourpub = Tourpub.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tourpub_params
      params.require(:tourpub).permit(:fname, :lname, :email, :description, :date, :cost)
    end
end
