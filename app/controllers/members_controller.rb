class MembersController < ApplicationController

  
  # GET /members
  # GET /members.xml
  def index
    @members = Member.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @members }
    end
  end

  # GET /members/1
  # GET /members/1.xml
  def show
    begin
      if params["search_by_email"].nil?
        @members = Member.find(:all)
      else
        @members = Member.find(:all, :conditions => ['email like ?', "%"+params["search_by_email"]+"%"])
      end
    rescue ActiveRecord::RecordNotFound
      logger.error("Attempt to access invalid member")
      flash[:notice] = "Member Not Found"
      redirect_to :action => :index
    else
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @member }
      end
    end
  end

  # GET /members/new
  # GET /members/new.xml
  def new
    @member = Member.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @member }
    end
  end

  # GET /members/1/edit
  def edit
    @member = Member.find(params[:id])
  end

  # POST /members
  # POST /members.xml
  def create
    @member = Member.new(params[:member])

    respond_to do |format|
      if @member.save
        flash[:notice] = 'Member was successfully created.'
        format.html { redirect_to(@member) }
        format.xml  { render :xml => @member, :status => :created, :location => @member }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @member.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /members/1
  # PUT /members/1.xml
  def update
    @member = Member.find(params[:id])

    respond_to do |format|
      if @member.update_attributes(params[:member])
        flash[:notice] = 'Member was successfully updated.'
        format.html { redirect_to(@member) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @member.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /members/1
  # DELETE /members/1.xml
  def destroy
    @member = Member.find(params[:id])
    @member.destroy

    respond_to do |format|
      format.html { redirect_to(members_url) }
      format.xml  { head :ok }
    end
  end

   def memberselect
    begin
     @member = Member.new(params[:member])
     @members = Member.find(:all, :conditions => ["firstname = ? OR lastname = ? OR emailid = ?" ,@member.firstname, @member.lastname, @member.emailid])
     if @members.length == nil
       redirect_to  :controller => "users", :action => "memberselect"
     else
     end
   end
  end
  
end
