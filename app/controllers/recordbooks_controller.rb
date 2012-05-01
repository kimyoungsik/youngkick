class RecordbooksController < ApplicationController
  before_filter :admin_approved, :only => [:new, :edit, :update, :destroy, :show]
  before_filter :authenticate_user!
  # GET /recordbooks
  # GET /recordbooks.json
  def index
     @recordbooks = Recordbook.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @recordbooks }
    end
  end

  # GET /recordbooks/1
  # GET /recordbooks/1.json
  def show
    @recordbook = Recordbook.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @recordbook }
    end
  end

  # GET /recordbooks/new
  # GET /recordbooks/new.json
  def new
    @recordbook = Recordbook.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @recordbook }
    end
  end

  # GET /recordbooks/1/edit
  def edit
    @recordbook = Recordbook.find(params[:id])
  end

  # POST /recordbooks
  # POST /recordbooks.json
  def create
    @recordbook = Recordbook.new(params[:recordbook])
    

    respond_to do |format|
      if @recordbook.save
        
        format.html { redirect_to @recordbook, notice: 'Recordbook was successfully created.' }
        format.json { render json: @recordbook, status: :created, location: @recordbook }
      else
        format.html { render action: "new" }
        format.json { render json: @recordbook.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /recordbooks/1
  # PUT /recordbooks/1.json
  def update
    @recordbook = Recordbook.find(params[:id])

    respond_to do |format|
      if @recordbook.update_attributes(params[:recordbook])
        format.html { redirect_to @recordbook, notice: 'Recordbook was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @recordbook.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recordbooks/1
  # DELETE /recordbooks/1.json
  def destroy
    @recordbook = Recordbook.find(params[:id])
    userid = @recordbook.user_id
    @recordbook.destroy
    updateUserRecord(User.find_by_id(userid))
    respond_to do |format|
      format.html { redirect_to recordbooks_url }
      format.json { head :no_content }
    end
  end
  
  private
  
  def admin_approved
     if !admin_signed_in?
       redirect_to root_path
     end
   end
   
  def updateUserRecord(user)
    win = 0
    loss = 0
    tie = 0
    record = 0
    forwardpoint = 0
    midfieldpoint = 0
    backpoint = 0
    keeperpoint = 0

    
    win += user.recordbooks.sum(:win)
    loss += user.recordbooks.sum(:loss)
    tie += user.recordbooks.sum(:tie)
    record = win+loss+tie 
    forwardpoint += user.recordbooks.sum(:forwardpoint)
    midfieldpoint += user.recordbooks.sum(:midfieldpoint) 
    backpoint += user.recordbooks.sum(:backpoint)
    keeperpoint += user.recordbooks.sum(:keeperpoint)
    totalpoint = forwardpoint+midfieldpoint+backpoint+keeperpoint
    user.update_attributes(:win => win, :loss => loss, :tie => tie, :record => record, :forwardpoint => forwardpoint, :midfieldpoint => midfieldpoint, :backpoint => backpoint, :keeperpoint=> keeperpoint, :point =>   totalpoint)
   end
end
