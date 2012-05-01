class ParticipationsController < ApplicationController
  before_filter :authenticate_user!
  def create
    @participation = current_user.participations.build(params[:participation])
    @ground = @participation.ground
    if @participation.save
      
      respond_to do |format|
        format.html { redirect_to @ground}
        format.js
      end
    else 
      redirect_to @ground
    end 
  end
  
  
  def destroy
    @participation = Participation.find(params[:id])       
    @ground = @participation.ground
    if @participation.destroy
      respond_to do |format|
        format.html { redirect_to @ground }
        format.js
      end
    else
      redirect_to ground_path(@ground)
    end
  end
  

end
