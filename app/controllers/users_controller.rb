class UsersController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html, :json
  
  def index
    @users = User.all
  end
  
  def update
    @user = User.find(params[:id])
    
    if @user.update_attributes(params[:user])
      respond_with @user
    else
      redirect_to root_path
    end
  end
  
  
  def show
    @user = User.find(params[:id])
  end
end
