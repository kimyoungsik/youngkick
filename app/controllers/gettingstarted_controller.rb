class GettingstartedController < ApplicationController
  skip_before_filter :noname_user
  
  def update
   @user = User.find(current_user.id)
    if @user.update_attributes(params[:user])
      # Sign in the user by passing validation in case his password changed
      sign_in @user, :bypass => true
      redirect_to root_path
    else
      render "step1"
    end
  end

  def step1
  end
end
