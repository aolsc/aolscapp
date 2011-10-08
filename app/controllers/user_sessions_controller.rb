class UserSessionsController < ApplicationController
  before_filter :ensure_login, :only => :destroy

  def new
    if current_user
      redirect_to root_url
    end

    @user_session = UserSession.new
  end
  
  def create
    @user_session = UserSession.new(params[:user_session])
    if params[:center][:city].blank?
      flash[:notice]  = 'Please enter a center'
      render :action => 'new'
    else
      @center = Center.find_by_city(params[:center][:city])
      session[:center_id] = @center.id
      if @user_session.save
        redirect_to root_url
      else
        render :action => 'new'
      end
    end
  end
  
  def destroy
    @user_session = UserSession.find
    @user_session.destroy
    
    redirect_to root_url
  end
end
