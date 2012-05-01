class KitsController < ApplicationController
  def index
    if user_signed_in?
      @kit = current_user.authored_kits.build
    end
    @kits = Kit.order("id").page(params[:page]).per_page(20)
  end
  
  def create
    @kit = current_user.authored_kits.build(params[:kit])
    @kit.save 
    respond_to do |format|
      format.html { redirect_back_or kits_path }
      format.js
    end
  end
  
  def destroy
    @kit = Kit.find(params[:id])
    @kit.destroy
    
    respond_to do |format|
      format.html { redirect_back_or kits_path }
      format.js
    end
  end
  
  private
  
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    clear_return_to
  end

  def clear_return_to
    session[:return_to] = nil
  end
end