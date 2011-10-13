class MemberAttendancesController < ApplicationController
  
  #add_crumb("Members") { |instance| instance.send :members_path }
  def index
    if params["csid"].nil?
      @members = Member.find(:all, :conditions => ['emailid LIKE ? and center_id=?', "#{params[:search]}%",session[:center_id]])
    else
      @tags = Tag.find(:all, :conditions => ["center_id = ?", session[:center_id]])
      @tag_names = []
      @tags.each do |tg|
        @tag_names << tg.name
      end
      @tg = @tag_names.map {|element|
        "'#{element}'"
      }.join(',');

      @member_attendances = MemberAttendance.find(:all, :conditions => ['course_schedule_id = ? and center_id=?', params[:csid], session[:center_id]])
      @members = []
      @member_attendances.each do |ma|
        unless ma.member.nil?
          @members << ma.member
        end
      end
      @csid = params["csid"]
      @cs = CourseSchedule.find(@csid)
      @course = @cs.course

    end
    unless params["mode"].nil?
      render :layout => "signup"
    end
  end

  def schedules
    @cs = CourseSchedule.find(:all, :conditions => ["center_id = ?", session[:center_id]], :limit => 5, :order => "start_date desc")
    render :layout => 'signup_schedules'
  end

  # GET /member_attendances/new
  # GET /member_attendances/new.xml
  def new
    @courses = Course.find(:all)
    
    @csidstr = params[:csid]
    unless @csidstr.blank? 
      @csid  = @csidstr.to_i
      @course_schedule = CourseSchedule.find(@csid)
      @sel_course=@course_schedule.course
      @sel_from_date = @course_schedule.start_date
    end
    
    @assistantusers = Role.find_by_role_name("Volunteer").users
    @assistants = []
    @assistantusers.each do |tu|
      @assistants << tu.member
    end

    render :layout => 'signup'
  end

  # POST /member_courses
  # POST /member_courses.xml
  def create
    @member_attendance = MemberAttendance.new

    @emailid = params[:emailid]
    # could come from new member page
    if @emailid.blank?
      @emailid = params[:member][:email_id]
    end

    unless @emailid.blank?
      @member_attendance.member = Member.find_by_emailid(@emailid, :conditions => ["center_id = ?", session[:center_id]])
    end
     
    @csidstr = params[:csid]
    unless @csidstr.blank?
      @csid  = @csidstr.to_i
      @member_attendance.course_schedule = CourseSchedule.find(@csid)
    end
     
    respond_to do |format|
      unless @member_attendance.course_schedule.nil?
        @csid = @member_attendance.course_schedule.id
      else
        @csid = ''
      end

      if @member_attendance.member.nil?
        flash[:notice] = 'Email could not be found. Please enter your details.'
        format.html { redirect_to :controller => "members", :action => "new", :csid => @csid, :mode => "signup", :emailid => @emailid }
      elsif @member_attendance.course_schedule.nil?
        flash[:notice] = 'Please choose a course and date'
        format.html { redirect_to :action => "new", :csid => @csid}
      else
        @member_attendance.center_id = session[:center_id]
        if @member_attendance.save
          format.html { redirect_to :action => "show", :csid => @member_attendance.course_schedule.id, :name => @member_attendance.member.fullname}
        else
          flash[:notice] = 'An error occured. Please enter details again.'
          format.html { redirect_to :action => "new", :csid => @member_attendance.course_schedule.id}
        end
      end
    
    end
  end

  def show
    @csid = params[:csid]
    @name = params[:name]
    render :layout => 'redirect'
  end

  def newschedule
    respond_to do |format|
      format.html 
    end
    render :layout => 'signup'
  end
end
