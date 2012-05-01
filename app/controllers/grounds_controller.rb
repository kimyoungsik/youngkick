class GroundsController < ApplicationController
before_filter :authenticate_user!, :except => [:index]
before_filter :authorized_user, :only => [:destroy, :edit, :update]
respond_to :html, :json
  # GET /grounds
  # GET /grounds.json
  def index
 
    @grounds = Ground.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @grounds }
    end
  end

  # GET /grounds/1
  # GET /grounds/1.json
  def show
    @ground = Ground.find(params[:id])
    @kits = @ground.kits.page(params[:page]).per_page(10)
    @kit = @ground.kits.build
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ground }
    end
  end

  # GET /grounds/new
  # GET /grounds/new.json
  def new
    # @ground = Ground.new
    @ground = current_user.grounds.build(params[:ground])
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ground }
    end
  end

  # GET /grounds/1/edit
  def edit
    @ground = Ground.find(params[:id])
  end

  # POST /grounds
  # POST /grounds.json
  def create
    # @ground = Ground.new(params[:ground])
    @ground = current_user.grounds.build(params[:ground])
    # member = @ground.forwardcount+ @ground.midfieldcount+ @ground.backcount  + @ground.keepercount
    
    respond_to do |format|
      if  @ground.save
        format.html { redirect_to @ground, notice: 'Ground was successfully created.' }
        format.json { render json: @ground, status: :created, location: @ground }
      else
        format.html { render action: "new" }
        format.json { render json: @ground.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /grounds/1
  # PUT /grounds/1.json
  def update
    @ground = Ground.find(params[:id])

    respond_to do |format|
      if @ground.update_attributes(params[:ground])
        if @ground.status == 'after'
          ateamforwards =  @ground.participations.find_all_by_team_id_and_position_id(1,1)
          setTeamForward(ateamforwards,'a')
          bteamforwards =  @ground.participations.find_all_by_team_id_and_position_id(2,1)
          setTeamForward(bteamforwards,'b')
          ateammidfields =  @ground.participations.find_all_by_team_id_and_position_id(1,2)
          setTeamMidfield(ateammidfields,'a')
          bteammidfields =  @ground.participations.find_all_by_team_id_and_position_id(2,2)
          setTeamMidfield(bteammidfields,'b')
          ateambacks =  @ground.participations.find_all_by_team_id_and_position_id(1,3)
          setTeamBack(ateambacks,'a')
          bteambacks =  @ground.participations.find_all_by_team_id_and_position_id(2,3)
          setTeamBack(bteambacks,'b')
          ateamkeepers =  @ground.participations.find_all_by_team_id_and_position_id(1,4)
          setTeamKeeper(ateamkeepers,'a')
          bteamkeepers =  @ground.participations.find_all_by_team_id_and_position_id(2,4)
          setTeamKeeper(bteamkeepers,'b')
        end
        # respond_with @ground
        format.html { redirect_to @ground, notice: 'Ground was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @ground.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /grounds/1
  # DELETE /grounds/1.json
  def destroy
    @ground = Ground.find(params[:id])
    @ground.destroy

    respond_to do |format|
      format.html { redirect_to grounds_url }
      format.json { head :no_content }
    end
  end
  
  
  def cancel
    @ground = Ground.find(params[:id])
    @ground.update_attributes(:status => 'cancel')

    respond_to do |format|
      format.html { redirect_to grounds_url }
      format.json { head :no_content }
    end
  end
  
  private
  
  def authorized_user
    @ground = Ground.find(params[:id])
    if !admin_signed_in? and current_user != @ground.user
      redirect_to grounds_path 
    end
  end
  
  def setTeamForward(teamforwards,team)
    teamforwards.each do |player|
      record = nil
      if(@ground.winner == team)
        record = Recordbook.create!(:ground_id => @ground.id,:user_id =>player.user_id,:position_id =>player.position_id,:win => 1,:score => @ground.score,:forwardpoint => 5)
      elsif(@ground.winner == 'tie')
        record = Recordbook.create!(:ground_id => @ground.id,:user_id =>player.user_id,:position_id =>player.position_id,:tie => 1,:score => @ground.score,:forwardpoint => 3)
      else
        record = Recordbook.create!(:ground_id => @ground.id,:user_id =>player.user_id,:position_id =>player.position_id,:loss => 1,:score => @ground.score,:forwardpoint => 1)
      end
      updateUserRecord(record)
    end
  end
  
  def setTeamMidfield(teammidfields,team)
    teammidfields.each do |player|
      record = nil
      if(@ground.winner == team)
        record =  Recordbook.create!(:ground_id => @ground.id,:user_id =>player.user_id,:position_id =>player.position_id,:win => 1,:score => @ground.score, :midfieldpoint => 5)
      elsif(@ground.winner == 'tie')
       record =  Recordbook.create!(:ground_id => @ground.id,:user_id =>player.user_id,:position_id =>teamforward.position_id,:tie => 1,:score => @ground.score , :midfieldpoint => 3)
      else
       record =  Recordbook.create!(:ground_id => @ground.id,:user_id =>player.user_id,:position_id =>player.position_id,:loss => 1,:score => @ground.score, :midfieldpoint => 1)
        
      end
      updateUserRecord(record)
    end
  end
  
  def setTeamBack(teambacks,team)
    teambacks.each do |player|
      record = nil
      if(@ground.winner == team)
       record =   Recordbook.create!(:ground_id => @ground.id,:user_id =>player.user_id,:position_id =>player.position_id,:win => 1,:score => @ground.score,:backpoint =>5)
      elsif(@ground.winner == 'tie')
       record =  Recordbook.create!(:ground_id => @ground.id,:user_id =>player.user_id,:position_id =>teamforward.position_id,:tie => 1,:score => @ground.score,:backpoint =>3)
      else
       record =  Recordbook.create!(:ground_id => @ground.id,:user_id =>player.user_id,:position_id =>player.position_id,:loss => 1,:score => @ground.score,:backpoint =>1)
        
      end
      updateUserRecord(record)
    end
  end
  
  def setTeamKeeper(teamkeepers,team)
    teamkeepers.each do |player|
      record = nil
      if(@ground.winner == team)
       record =   Recordbook.create!(:ground_id => @ground.id,:user_id =>player.user_id,:position_id =>player.position_id,:win => 1,:score => @ground.score,:keeperpoint =>10)
      elsif(@ground.winner == 'tie')
       record =   Recordbook.create!(:ground_id => @ground.id,:user_id =>player.user_id,:position_id =>teamforward.position_id,:tie => 1,:score => @ground.score,:keeperpoint =>8)
      else
       record =  Recordbook.create!(:ground_id => @ground.id,:user_id =>player.user_id,:position_id =>player.position_id,:loss => 1,:score => @ground.score,:keeperpoint =>5)
        
      end
      updateUserRecord(record)
    end
  end
    
  def updateUserRecord(recordbook)
    # debugger
    win = 0
    loss = 0
    tie = 0
    record = 0
    forwardpoint = 0
    midfieldpoint = 0
    backpoint = 0
    keeperpoint = 0

    user = recordbook.user
    win += user.recordbooks.sum(:win)
    loss += user.recordbooks.sum(:loss)
    tie += user.recordbooks.sum(:tie)
    record = win+loss+tie 
    forwardpoint += user.recordbooks.sum(:forwardpoint)
    midfieldpoint += user.recordbooks.sum(:midfieldpoint) 
    backpoint += user.recordbooks.sum(:backpoint)
    keeperpoint += user.recordbooks.sum(:keeperpoint)
    totalpoint = forwardpoint+midfieldpoint+backpoint+keeperpoint
    level = get_level(totalpoint, keeperpoint)
    user.update_attributes(:win => win, :loss => loss, :tie => tie, :record => record, :forwardpoint => forwardpoint, :midfieldpoint => midfieldpoint, :backpoint => backpoint, :keeperpoint=> keeperpoint, :point =>   totalpoint, :level => level)
  end
    
  
  def get_level(point, keeperpoint)
    level = 1
    if 10 <= point and point < 20
     level = 2
    elsif 20 <= point and point < 40 and keeperpoint > 0
      level = 3
    elsif 40 <= point and point < 80 and keeperpoint > 5
      level = 4
    elsif 80 <= point and point < 130 and keeperpoint > 10
      level =5
    elsif 130 <= point and point < 190 and keeperpoint > 15
      level =6
    elsif 190 <= point and point < 260 and keeperpoint > 20
      level =7
    elsif 260 <= point and point < 340 and keeperpoint > 25
      level =8 
    elsif 340 <= point and point < 430 and keeperpoint > 30
      level =9
    elsif 430 <= point and point < 530 and keeperpoint > 35
      level =10
    end
    level
  end
        
   
  
  
           
end
