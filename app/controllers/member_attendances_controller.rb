class MemberAttendancesController < ApplicationController
  #add_crumb("Members") { |instance| instance.send :members_path }
  def index
    @members = Member.find(:all, :conditions => ['emailid LIKE ?', "%#{params[:search]}%"])
  end

  # GET /member_attendances/new
  # GET /member_attendances/new.xml
  def new
    
    
    @member_attendance = MemberAttendance.new
    @courses = Course.find(:all)
    
    @csidstr = params[:csid]
    unless @csidstr.blank?
      @csid  = @csidstr.to_i
      @course_schedule = CourseSchedule.find(@csid)
      @sel_course=@course_schedule.course.id
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

    @member_attendance = MemberAttendance.new(params[:memberattendance])
    logger.debug "******"
    
    logger.debug "email id " + params[:member][:email_id]
    @member_attendance.member = Member.find_by_emailid(params[:member][:email_id]) unless params[:member][:email_id].blank?
    @member_attendance.course_schedule= getOrCreateCourseSched( params[:coursesel][:id],Time.parse(params[:start_date]).to_time.utc)

    respond_to do |format|
      if @member_attendance.save
        flash[:notice] = 'Member ' + @member_attendance.member.firstname + " checked in"
        format.html { redirect_to :action => "new", :csid => @member_attendance.course_schedule.id}
        format.xml  { render :xml => @member_attendance, :status => :created, :location => @member_attendance }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @member_attendance.errors, :status => :unprocessable_entity }
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
end
