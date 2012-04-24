class PhotosController < ApplicationController
  def index
    if !(params[:user_id]).nil?
      @user = User.find(params[:user_id])
      @photos = @user.photos
    end
  end
  
  def new
    if !(params[:user_id]).nil?
      @user = User.find(params[:user_id])
      @photo = @user.photos.build
    else
      @photo = Photo.new
    end
  end
  
  def create
    @photo = current_user.authored_photos.build(params[:photo])    
    if @photo.save
      if @photo.photoable_type == "User"
        render :edit
      else
        redirect_to @photo 
      end
    else
      redirect_to root_path
      # redirect_to terms_path
    end
  end
  
  def show
    @photo = Photo.find(params[:id])
  end
  
  def edit
    @photo = Photo.find(params[:id])
  end
  
  def update
    @photo = Photo.find(params[:id])
    if @photo.update_attributes(params[:photo]) and @photo.user == current_user
      if @photo.photoable_type == "User"
        redirect_to current_user
      else
        redirect_to photo_path(@photo)        
      end
    else
      render 'edit'
    end
  end
  
end
