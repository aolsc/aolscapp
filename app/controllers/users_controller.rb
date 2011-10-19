class UsersController < ApplicationController
  add_crumb("Users") { |instance| instance.send :users_path }
 # filter_resource_access

  # GET /users
  # GET /users.xml
  def index
    if session[:current_user_super_admin]
      @users = User.find(:all,:order => 'username')
    else
      @users = User.find(:all,:order => 'username', :joins => :member, :conditions => ['members.center_id = ?', session[:center_id]]).paginate :page => params[:page], :per_page => 10
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  def memberselectold
  puts "in membersselect"
  @members = Member.find_by_sql(["select * from members m, member_courses mc where m.id = mc.member_id" ])
  if @members.length > 0
    for m in @members
      puts m.firstname
    end
    puts " worked fine"
  end
end

  def membersearch
    respond_to do |format|
      format.html # membersearch.html.erb
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
  
    begin
      if params["search_by_username"].nil?
        if session[:current_user_super_admin]
          @users = User.find(:all,:order => 'username')
        else
          @users = User.find(:all,:order => 'username', :joins => :member, :conditions => ['members.center_id = ?', session[:center_id]]).paginate :page => params[:page], :per_page => 10
        end
      else
        if session[:current_user_super_admin]
          @users = User.find(:all, :conditions => ['username like ?', "%"+params["search_by_username"]+"%"])
        else
          @users = User.find(:all,:order => 'username', :joins => :member, :conditions => ['members.center_id = ? and username like ?', session[:center_id], "%"+params["search_by_username"]+"%"]).paginate :page => params[:page], :per_page => 10
        end
      end
      rescue ActiveRecord::RecordNotFound
        logger.error("Attempt to access invalid user")
        flash[:notice] = "User Not Found"
        redirect_to :action => :index
      else
        respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @users }
      end
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @mem = Member.find(params[:id])
    @user = User.new
    if session[:current_user_super_admin]
      @roles = Role.find(:all)
    else
      @roles = Role.find(:all, :conditions => ["id <> 1"])
    end
    @mem_emailid = @mem.emailid

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
    @session_user = session[:user]
    if @session_user.is_super_admin
      @roles = Role.find(:all)
    else
      @roles = Role.find(:all, :conditions => ["id <> 1"])
    end

    
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])
    @user.memberid = params[:user][:member_id]
    @user.roles = Role.find(params[:role_ids]) if params[:role_ids]

    if @user.save
       flash[:notice] = 'Registration successful.'
       redirect_to users_path
    else
      @roles = Role.find(:all)
      render :action => "new"
     end
#
#    if @validateuser.length .nil?
#       @user.save
#        flash[:notice] = 'User was successfully created.'
#        format.html { redirect_to(user) }
#        format.xml  { render :xml => @user, :status => :created, :location => @user }
#    else
#      flash[:notice] = 'User already Exists.'
#      format.html { render :action => "new" }
#      format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
#    end


#    respond_to do |format|
#      if @user.save
#        flash[:notice] = 'User was successfully created.'
#        format.html { redirect_to(@user) }
#        format.xml  { render :xml => @user, :status => :created, :location => @user }
#      else
#        format.html { render :action => "new" }
#        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
#      end
#    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    params[:user][:role_ids] ||= []
    @user = User.find(params[:id])
    # @user.roles = Role.find(params[:role_ids]) if params[:role_ids]

    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = 'User was successfully updated.'
        if permitted_to? :index, User.new
          format.html { redirect_to(@user) }
        else
          format.html { redirect_to(:root) }
        end
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end

  def memberselect
    begin
     @member = Member.new(params[:member])
     if session[:current_user_super_admin]
       @members_with_users = Member.all(:conditions => ["(firstname = ? OR lastname = ? OR emailid = ?)" ,@member.firstname, @member.lastname, @member.emailid], :joins => :user)
       @members_all = Member.find(:all, :conditions => ["(firstname = ? OR lastname = ? OR emailid = ?)" ,@member.firstname, @member.lastname, @member.emailid])
     else
       @members_with_users = Member.all(:conditions => ["(firstname = ? OR lastname = ? OR emailid = ?) and center_id = ?" ,@member.firstname, @member.lastname, @member.emailid, session[:center_id].to_s], :joins => :user)
       @members_all = Member.find(:all, :conditions => ["(firstname = ? OR lastname = ? OR emailid = ?) and center_id = ?" ,@member.firstname, @member.lastname, @member.emailid, session[:center_id].to_s])
     end
     @members = []
     for m in @members_all
       if !@members_with_users.include?(m)
         @members << m
       end
     end

     
      rescue ActiveRecord::RecordNotFound
        logger.error("Attempt to access invalid user")
        flash[:notice] = "Member Not Found"
        redirect_to :action => :memberselect
      else
        respond_to do |format|
        format.html # memberselect.html.erb
        format.xml  { render :xml => @members }
      end
   end
  end

end
