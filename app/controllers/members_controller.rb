class MembersController < ApplicationController
  add_crumb("Members") { |instance| instance.send :members_path }
 
  # GET /members
  # GET /members.xml
  def index
    @members = Member.paginate :page => params[:page], :per_page => 10

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @members }
    end
  end

  # GET /members/1
  # GET /members/1.xml
  def show
    
      if params["search_by_name"].empty? and params["search_by_email"].empty? then
        @members = Member.find(:all).paginate :page => params[:page], :per_page => 10
      else
        unless params["search_by_name"].empty? and params["search_by_email"].empty?
            @members = Member.find(:all, :conditions => ['(firstname like ? or lastname like ?) and emailid like ?', "%"+params["search_by_name"]+"%", "%"+params["search_by_name"]+"%", "%"+params["search_by_email"]+"%"]).paginate :page => params[:page], :per_page => 10
       else
         unless params["search_by_name"].empty?
            @members = Member.find(:all, :conditions => ['firstname like ? or lastname like ?', "%"+params["search_by_name"]+"%", "%"+params["search_by_name"]+"%", "%"+params["search_by_"]+"%"]).paginate :page => params[:page], :per_page => 10
         else
            @members = Member.find(:all, :conditions => ['emailid like ?', "%"+params["search_by_email"]+"%"]).paginate :page => params[:page], :per_page => 10
          end
        end
      end
         
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @member }
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
    @validatemember = Member.find(:all, :conditions => ["firstname = ? AND lastname = ? AND emailid = ?", @member.firstname, @member.lastname, @member.emailid
      ])
    if @validatemember.length == 0
      @validateemail = Member.find(:all, :conditions => ["emailid = ? ", @member.emailid])
      if @validateemail.length == 0
        @member.save
        flash[:notice] = 'Member was successfully created.'
        redirect_to :action => "index"
      else
        flash[:notice] = 'Member already Exists.'
        render :action => "new"
      end
    else
      flash[:notice] = 'Member already Exists.'
      render :action => "new"
      #      @member.save
      #      flash[:notice] = 'Member was successfully created.'
      #      redirect_to :action => "index"
    end

    #    respond_to do |format|
    #      if @member.save
    #        flash[:notice] = 'Member was successfully created.'
    #        format.html { redirect_to(@member) }
    #        format.xml  { render :xml => @member, :status => :created, :location => @member }
    #      else
    #        format.html { render :action => "new" }
    #        format.xml  { render :xml => @member.errors, :status => :unprocessable_entity }
    #      end
    #    end
  end

  # PUT /members/1
  # PUT /members/1.xml
  def update
    @member = Member.find(params[:id])

    respond_to do |format|
      if @member.update_attributes(params[:member])
        flash[:notice] = 'Member was successfully updated.'
        redirect_to :action => "index"
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

  #   def memberselect
  #    begin
  #     @member = Member.new(params[:member])
  #     @members = Member.find(:all, :conditions => ["firstname = ? OR lastname = ? OR emailid = ?" ,@member.firstname, @member.lastname, @member.emailid])
  #     if @members.length == nil
  #       redirect_to  :controller => "users", :action => "memberselect"
  #     else
  #     end
  #   end
  #  end


  def insert_feedback
    @feedback = MemberGeneralFeedback.new(params[:feedback])
    @member_id = @feedback.member_id

    if @feedback.save
      flash[:notice] = "Your feedback was successfully created"
    else
      flash[:notice] = "Failed to create Feedback"
    end
    @feedbacks = MemberGeneralFeedback.find(:all, :conditions => ["member_id = ?", @member_id])
   
    puts "in insert_feedback"
    puts params[:feedback]
    puts params[:member_id]
     
  end

  def insert_course_interest
    #  puts params[:name]

    @course_interests = MemberCourseInterest.new(params[:membercourseinterest])

    params[:name].each do |a|
      puts "vakdd"
      @course_interests.course_id = a
      puts @course_interests.course_id

      @find_member = MemberCourseInterest.find(:all, :conditions => ["course_id = ?",@course_interests.course_id])
      if @find_member.length == 0
        @course_interests.save
      end
    end
    

  end

  def member_course_interest

    @courses = Course.find(:all)

  end
end
 
