class CrsSchedulesController < ApplicationController
  add_crumb("Courses") { |instance| instance.send :courses_path }
  add_crumb("Course Schedules") { |instance| instance.send :course_schedules_path }

 
  # GET /course_schedules
  # GET /course_schedules.xml
  def index
    @course = Course.find(params[:course_id])
    @course_schedules = @course.course_schedules.paginate :page => params[:page], :per_page => 10

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @course_schedules }
    end
  end

  # GET /course_schedules/1
  # GET /course_schedules/1.xml
  def show
    @course_schedule = CourseSchedule.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @course_schedule }
    end
  end

  # GET /course_schedules/new
  # GET /course_schedules/new.xml
  def new
    @courses = Course.find(:all)

    @course_schedule = CourseSchedule.new(params[:courseschedule])
        @teacherusers = Role.find_by_role_name("Teacher").users
    @teachers = []
    @teacherusers.each do |tu|
       @teachers << tu.member
    end

    @assistantusers = Role.find_by_role_name("Volunteer").users
    @assistants = []
    @assistantusers.each do |tu|
       @assistants << tu.member
    end
    render :layout => 'signup'
  end

  # GET /course_schedules/1/edit
  def edit
    @course_schedule = CourseSchedule.find(params[:id])
    @course = @course_schedule.course

    @teacher_sel = @course_schedule.teacher
    @assistant_sel = @course_schedule.assistant
    @assistant2_sel = @course_schedule.assistant2
    
    @teacherusers = Role.find_by_role_name("Teacher").users
    @teachers = []
    @teacherusers.each do |tu|
       @teachers << tu.member
    end

    @assistantusers = Role.find_by_role_name("Volunteer").users
    @assistants = []
    @assistantusers.each do |tu|
       @assistants << tu.member
    end

    @start_date = @course_schedule.start_date
    @end_date = @course_schedule.end_date


  end

  # POST /course_schedules
  # POST /course_schedules.xml
  def create
    @course = Course.find(params[:coursesel][:id])
    #@course_schedule = @course.course_schedules.build(params[:course_schedule])
    @course_schedule = CourseSchedule.new
    @course_schedule.course_id = params[:coursesel][:id]
    @course_schedule.start_date = Time.parse(params[:start_date])
    if !params[:end_date].empty?
      @course_schedule.end_date = Time.parse(params[:end_date])
    end
    @teach = params[:teachers][:id]
    @assis = params[:assistants][:id]
    @assis2 = params[:assistants2][:id]
    @course_schedule.teacher_id = @teach
    @course_schedule.volunteer_id = @assis
    @course_schedule.volunteer_id2 = @assis2

      
    @course_schedule.last_updated_by = current_user[:id]
      @cs = CourseSchedule.find(:all, :conditions => ["start_date = ? and course_id=? and teacher_id=?", Time.parse(params[:start_date]).to_time.utc, @course.id, @teach])
      if !@cs.empty?
        flash[:notice] = 'Could not create course schedule. A course schedule with the same start date, teacher for this course already exists.'
        redirect_to new_crs_schedule_path
      elsif @course_schedule.save
        redirect_to root_path
      else
        flash[:notice] = 'Could not create course schedule due to system errors.'
        redirect_to new_crs_schedule_path
      end
  end

  # PUT /course_schedules/1
  # PUT /course_schedules/1.xml
  def update
    @course_schedule = CourseSchedule.find(params[:id])
    @course_schedule.last_updated_by = current_user[:id]

    @course_schedule.start_date = Time.parse(params[:start_date])
    if !params[:end_date].empty?
      @course_schedule.end_date = Time.parse(params[:end_date])
    end
    @teach = params[:teacher_sel][:id]
    @assis = params[:assistant_sel][:id]
    @assis2 = params[:assistant2_sel][:id]
    @course_schedule.teacher_id = @teach
    @course_schedule.volunteer_id = @assis
    @course_schedule.volunteer_id2 = @assis2

    @course = @course_schedule.course
      @cs = CourseSchedule.find(:first, :conditions => ["start_date = ? and course_id=? and teacher_id=?", Time.parse(params[:start_date]).to_time.utc, @course.id, @teach])
      puts "hello ->>>"
      if !@cs.nil? and @cs.id != @course_schedule.id
        flash[:notice] = 'Could not create course schedule. A course schedule with the same start date, teacher for this course already exists.'
        redirect_to(course_course_schedules_path(@course.id))
      elsif @course_schedule.save
        flash[:notice] = 'CourseSchedule was successfully created.'
        redirect_to(course_course_schedules_path(@course.id))
      else
        flash[:notice] = 'Could not create course schedule due to system errors.'
        redirect_to course_course_schedules_path(@course.id)
      end

  end

  # DELETE /course_schedules/1
  # DELETE /course_schedules/1.xml
  def destroy
    @course_schedule = CourseSchedule.find(params[:id])
    @course_schedule.destroy

    respond_to do |format|
      format.html { redirect_to(course_schedules_url) }
      format.xml  { head :ok }
    end
  end

  def newschedule

  end
end
