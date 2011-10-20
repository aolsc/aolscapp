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
    if @user_session.save
      @user = User.find_by_username(@user_session.username)
      @member = Member.find_by_id(@user.member_id)
      session[:center_id] = @member.center.id.to_s
      session[:user_full_name] = @member.fullname_with_role
      session[:user] = @user
      session[:current_user_super_admin] = @user.is_super_admin
      redirect_to root_url
    else
      render :action => 'new'
    end
  end
  
  def destroy
    @user_session = UserSession.find
    @user_session.destroy
    
    redirect_to root_url
  end
end
