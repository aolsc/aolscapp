class MembersController < ApplicationController
  add_crumb("Members") { |instance| instance.send :members_path }
  
  
  #filter_access_to :all
  autocomplete_for :member, :emailid, :query => "%%{field} LIKE(%%{query}) AND deleted_at IS NULL", :mask => '%%{value}%%' do |items|
    items.map{|item| "#{item.firstname} #{item.lastname};#{item.emailid}"}.join("\n")
  end

  # GET /members
  # GET /members.xml
  def index
      @session_member_id = session[:user].member.id
      @conn_ids = []
      @session_member = Member.find(@session_member_id)
      @mcs = @session_member.member_connections
      unless @mcs.empty?
        @mcs.each do |mc|
           @conn_ids << mc.connected_member_id
        end
      end

      unless params["myconn"].blank?
        @myconn = params["myconn"]
        @search = Member.id_eq_any(@conn_ids).search(params[:search])
      else
        @search = Member.descend_by_created_at.search(params[:search])
      end

      unless params[:search_by_tags].blank?
        @searchtags = Tag.name_like(params[:search_by_tags])
        @searchtags_ids = []
        @searchtags.each do |tg|
           @searchtags_ids << tg.id
        end
        @search.member_taggings_tag_id_eq_any(@searchtags_ids)
      end

    

    if !params[:from_date_cal].blank?
      @report_start_date = Time.parse(params[:from_date_cal])
      @search.member_attendances_created_at_greater_than(@report_start_date)
    end

    if !params[:end_date_cal].blank?
      @report_end_date = Time.parse(params[:end_date_cal])
      @search.member_attendances_created_at_less_than(@report_end_date)
    end

    unless params[:coursedd].blank?
      @coursedd = params[:coursedd][:id]
      sql = CourseSchedule.send(:construct_finder_sql, :select => 'id', :conditions => ["course_id = ?",@coursedd])
      @cids = CourseSchedule.connection.select_values(sql)
      @search.member_attendances_course_schedule_id_eq_any(@cids)
    end

    @csid = params["csid"]
    unless @csid.blank?
          @cs = CourseSchedule.find(@csid)
          @course = @cs.course
      @search.member_attendances_course_schedule_id_eq_any(@csid)
    end

    if params["all"].blank?
      @members = @search.all.paginate :page => params[:page], :per_page => 10
    else
      @members = @search.all_members_cached(session[:center_id]).paginate :page => params[:page], :per_page => 10
    end

    @usermembers = User.user_members_cached(session[:center_id])
    @tg = Tag.get_tag_names_cached(session[:center_id])
    @courses = Course.all_cached
    @cs_id = -1
    unless params["mode"].blank?
      render :layout => "signup", :template => "member_attendances/index"
    end
  end

  def show
    @tags = Tag.find(:all,:conditions => ["center_id=?", session[:center_id]])
    @tag_names = []
    @tags.each do |tg|
       @tag_names << tg.name
    end
    @tg = @tag_names.map {|element|
        "'#{element}'"
      }.join(',');

        @courses = Course.find(:all)
    @courseschedules = CourseSchedule.find(:all, :conditions => ["center_id = ?", session[:center_id]], :order => "start_date desc").paginate :page => params[:page], :per_page => 10
    @cs_id = -1

    begin
      @search = Member.search(params[:search])
      @members = @search.all.center_id_eq(session[:center_id]).ascend_by_firstname.paginate :page => params[:page], :per_page => 10
         
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
    @centers = Center.find(:all)

    @mode = params[:mode]
    @csid = params[:csid]
    @emailid = params[:emailid]
    @myconn = params[:myconn]
    unless @emailid.nil?
      @member.emailid = @emailid
    end
    unless @mode.blank?
      render :layout => 'signup'
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
    @session_member_id = session[:user].member.id
    @validatemember = Member.find(:all, :conditions => ["emailid = ?", @member.emailid])
    if @validatemember.length == 0
      @mode = params[:mode]
      @myconn = params[:myconn]
      if session[:current_user_super_admin] and @mode.blank?
        @member.center_id = params[:centersel][:id]
      else
        @member.center_id = session[:center_id]
      end
      @member.gender = params[:gender]
      if @member.save
        
        if @mode.blank?
          if @myconn.blank?
            flash[:notice] = 'Member was successfully created.'
            redirect_to params.merge!(:action => "index")
          else
            @member_connection = MemberConnection.new
            @member_connection.member_id = @session_member_id
            @member_connection.connected_member_id = @member.id
            @member_connection.save
            flash[:notice] = 'Member was successfully created.'
            redirect_to params.merge!(:action => "index", :myconn=>@myconn)
          end
        else
          @csid = params[:csid]
          @member_attendance = MemberAttendance.new
          @member_attendance.member = @member
          @member_attendance.center_id = session[:center_id]
          @member_attendance.course_schedule = CourseSchedule.find(@csid)
          if @member_attendance.save
          end
          redirect_to params.merge!(:controller=>"member_attendances", :action=>"show", :csid => @csid, :emailid => @member.emailid, :name => @member.fullname)
        end
      else
        if params[:mode].nil?
          render :action => "new", :csid => @csid, :mode => params[:mode]
        else
          render :action => "new", :csid => @csid, :mode => params[:mode], :layout => 'signup'
        end
      end
    else
      if params[:mode].blank?
        flash[:notice] = 'Member already Exists.'
        redirect_to params.merge!(:action => "new")
      else
          @csid = params[:csid]
          @member_attendance = MemberAttendance.new
          @member_attendance.member = @member
          @member_attendance.center_id = session[:center_id]
          @member_attendance.course_schedule = CourseSchedule.find(@csid)
          if @member_attendance.save
          end
          redirect_to params.merge!(:controller=>"member_attendances", :action=>"show", :csid => @csid, :emailid => @member.emailid, :name => @member.fullname)
      end
    end

  end

  def save_tags
    puts params[:sel_tags]
    puts params[:mem_id]
    @member = Member.find(params[:mem_id])
    @member.member_taggings.destroy_all
    @sel_tags =params[:sel_tags].split(",")
    @sel_tags.each do |sel_tag|
      @member_tag = MemberTagging.new
      @member_tag.member = @member
      @tag = Tag.find_by_name(sel_tag)
      @member_tag.tag = @tag
      @member_tag.save
    end
    
    respond_to do |format|
      format.html { redirect_to members_path }
      format.js
    end
  end

  def save_notes
    @member = Member.find(params[:mem_id])
    @member_note = MemberNote.new
    @member_note.member = @member
    @member_note.author = session[:user]
    @member_note.note = params[:addednote]
    @member_note.save

    respond_to do |format|
      format.html { redirect_to members_path }
      format.js
    end
  end
  # PUT /members/1
  # PUT /members/1.xml

def save_fdate
    @member = Member.find(params[:mem_id])
    @member.followupdate = Time.parse(params[:fdate])
    @member.save

    respond_to do |format|
      format.html { redirect_to members_path }
      format.js
    end
  end

  def add_connection
    
    @session_member_id = session[:user].member.id
      @conn_ids = []
      @session_member = Member.find(@session_member_id)
      @mcs = @session_member.member_connections
      unless @mcs.empty?
        @mcs.each do |mc|
           @conn_ids << mc.connected_member_id.to_s
        end
    end

    @memto = Member.find(params[:membersel_id])
    @memfrom = Member.find(params[:memfrom_id])
      MemberConnection.connected_member_id_eq(@memto.id).destroy_all

    @member_connection = MemberConnection.new
    @member_connection.member_id = @memfrom.id
    @member_connection.connected_member_id = @memto.id
    @member_connection.save

    respond_to do |format|
      format.html { redirect_to members_path }
      format.js
    end
  end


  def remove_connection
    @member = Member.find(params[:mem_id])
    @session_member_id = session[:user].member.id
    @conn_ids = []
    @session_member = Member.find(@session_member_id)
    @mcs = @session_member.member_connections
    unless @mcs.empty?
        @mcs.each do |mc|
           @conn_ids << mc.connected_member_id.to_s
          if mc.member_id = @member.id
            mc.delete
          end
        end
    end

    respond_to do |format|
      format.html { redirect_to members_path }
      format.js
    end
  end


  def update
    @member = Member.find(params[:id])
    @member.updateby = current_user
    @member.gender = params[:gender]
    if @member.update_attributes(params[:member])
      flash[:notice] = 'Member was successfully updated.'
      redirect_to :action => "index"
    else
      flash[:notice] = 'An error occured updating the member information.'
      redirect_to :action => "index"
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

  def myconnections
      @session_member_id = session[:user].member.id
      @conn_ids = []
      @session_member = Member.find(@session_member_id)
      @mcs = @session_member.member_connections
      unless @mcs.empty?
        @mcs.each do |mc|
           @conn_ids << mc.connected_member_id
        end
      end

      @search = Member.search(params[:search])
      unless params[:search_by_tags].blank?
        @searchtags = Tag.name_like(params[:search_by_tags])
        @searchtags_ids = []
        @searchtags.each do |tg|
           @searchtags_ids << tg.id
        end
        @search.member_taggings_tag_id_eq_any(@searchtags_ids)
      end


    if !params[:from_date_cal].blank?
      @report_start_date = Time.parse(params[:from_date_cal])
      @search.member_attendances_created_at_greater_than(@report_start_date)
    end

    if !params[:end_date_cal].blank?
      @report_end_date = Time.parse(params[:end_date_cal])
      @search.member_attendances_created_at_less_than(@report_end_date)
    end

    unless params[:coursedd].blank?
      @coursedd = params[:coursedd][:id]
      sql = CourseSchedule.send(:construct_finder_sql, :select => 'id', :conditions => ["course_id = ?",@coursedd])
      @cids = CourseSchedule.connection.select_values(sql)
      @search.member_attendances_course_schedule_id_eq_any(@cids)
    end

    @members = @search.all.paginate :page => params[:page], :per_page => 10


      @center_id = session[:center_id]+""
    #if session[:current_user_super_admin]
     # @members = Member.find(:all, :order => 'firstname').paginate :page => params[:page], :per_page => 10
    #else
#      @members = Member.union([{:conditions => ['center_id = ?', session[:center_id]]}, {:conditions => ['id = ?', '33']}], {:order => 'firstname'}).paginate :page => params[:page], :per_page => 10
 #   end
    @tags = Tag.find(:all,:conditions => ["center_id=?", session[:center_id]])
    @tag_names = []
    @tags.each do |tg|
       @tag_names << tg.name
    end
    @tg = @tag_names.map {|element|
        "'#{element}'"
      }.join(',');

    @courses = Course.find(:all)
    @courseschedules = CourseSchedule.find(:all, :conditions => ["center_id = ?", session[:center_id]], :order => "start_date desc").paginate :page => params[:page], :per_page => 10
    @cs_id = -1

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @members }
    end
    
  end
end
 
