class UsersController < ApplicationController
  # GET /users
  # GET /users.xml
  def index
    @users = User.all

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

  # GET /users/1
  # GET /users/1.xml
  def show
  
    begin
      if params["search_by_username"].nil?
        @users = User.find(:all)
      else
        @users = User.find(:all, :conditions => ['username like ?', "%"+params["search_by_username"]+"%"])
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

    puts "in new "

    @mem = Member.new(params[:members])
   
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = current_user
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])
    if @user.save
       flash[:notice] = 'Registration successful.'
       redirect_to root_url
    else
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
    @user = current_user

    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = 'User was successfully updated.'
        format.html { redirect_to(@user) }
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
     @members = Member.find(:all, :conditions => ["firstname = ? OR lastname = ? OR emailid = ?" ,@member.firstname, @member.lastname, @member.emailid])
     
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
