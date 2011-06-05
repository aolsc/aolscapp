class MemberAttendancesController < ApplicationController
  #add_crumb("Members") { |instance| instance.send :members_path }
  def index
    if params["csid"].nil?
      @members = Member.find(:all, :conditions => ['emailid LIKE ?', "#{params[:search]}%"])
    else
      @member_attendances = MemberAttendance.find(:all, :conditions => ['course_schedule_id = ?', params[:csid]])
      @members = []
      @member_attendances.each do |ma|
        @members << ma.member
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
    @cs = CourseSchedule.find(:all, :conditions => ["DATE(start_date) = ?", Time.now.utc.strftime("%Y-%m-%d")], :order => "start_date desc")
    render :layout => 'signup'
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
    else
      @current_cs = CourseSchedule.find(:all, :conditions => ["start_date between ? and ?", Time.now.utc - 45.minutes, Time.now.utc + 45.minutes])
      if !@current_cs.empty?
        if @current_cs.size < 2
          @current_cs.each do | cs |
            @csid = cs.id
            @sel_course=cs.course
            @sel_from_date = cs.start_date
          end
        end
      else
        @nocs = true
      end
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
    logger.debug "******"

    @emailid = params[:emailid]
    if @emailid.blank?
      @emailid = params[:member][:email_id]
    end

    unless @emailid.blank?
      @member_attendance.member = Member.find_by_emailid(@emailid)
    end
     
    @csidstr = params[:csid]
    if @csidstr.blank?
      @member_attendance.course_schedule= getOrCreateCourseSched( params[:coursesel][:id],Time.parse(params[:start_date]).to_time.utc)
    else
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
        format.html { redirect_to :controller => "members", :action => "new", :csid => @csid, :mode => "signup" }
      elsif @member_attendance.course_schedule.nil?
        flash[:notice] = 'Please choose a course and date'
        format.html { redirect_to :action => "new", :csid => @csid}
      else
        if @member_attendance.save
          flash[:notice] = 'Welcome ' + @member_attendance.member.fullname + "!\nThank you for signing in. "
          format.html { redirect_to :action => "new", :csid => @member_attendance.course_schedule.id}
        else
          flash[:notice] = 'An error occured. Please enter details again.'
          format.html { redirect_to :action => "new", :csid => @member_attendance.course_schedule.id}
        end
      end
    
    end
  end

  def getOrCreateCourseSched ( courseId,courseDate)
    logger.debug "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    @cs = CourseSchedule.find(:first, :conditions => ["start_date = ? and course_id=?", courseDate, courseId])
    
    if @cs.nil?

      t =  Hash[
        'course_id',courseId,
        'start_date',courseDate,
        'volunteer_id',current_user[:id],
        'last_updated_by',current_user[:id],
      ];

      @course_schedule = CourseSchedule.new(t)

      @course_schedule.save
      logger.debug "created cs "
      return @course_schedule
    else
      puts "####" +  @cs.inspect
      @cs.last_updated_by = current_user[:id]
      @cs.save
      logger.debug "saved cs "
      return @cs
    end
  end

  def newschedule
    respond_to do |format|
      format.html 
    end
    render :layout => 'signup'
  end
end
