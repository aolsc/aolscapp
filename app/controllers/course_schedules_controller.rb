class CourseSchedulesController < ApplicationController
  add_crumb("Courses") { |instance| instance.send :courses_path }
  add_crumb("Course Schedules") { |instance| instance.send :course_schedules_path }

  filter_access_to :all
  
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
    @course = Course.find(params[:id])
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

  end

  # GET /course_schedules/1/edit
  def edit
    @course_schedule = CourseSchedule.find(params[:id])
  end

  # POST /course_schedules
  # POST /course_schedules.xml
  def create
    @course = Course.find(params[:course_id])
    #@course_schedule = @course.course_schedules.build(params[:course_schedule])
    @course_schedule = CourseSchedule.new
    @course_schedule.course_id = params[:course_id]
    @course_schedule.start_date = params[:start_date]
    @course_schedule.end_date = params[:end_date]
    @teach = params[:teachers][:id]
    @assis = params[:assistants][:id]
    @course_schedule.teacher_id = @teach
    @course_schedule.volunteer_id = @assis
    puts "tc"
    puts params[:start_date]
    puts "end"


    respond_to do |format|
      if @course_schedule.save
        flash[:notice] = 'CourseSchedule was successfully created.'
        format.html { redirect_to(course_course_schedules_path(@course.id))}
        format.xml  { head :ok }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @course_schedule.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /course_schedules/1
  # PUT /course_schedules/1.xml
  def update
    @course_schedule = CourseSchedule.find(params[:id])

    respond_to do |format|
      if @course_schedule.update_attributes(params[:course_schedule])
        flash[:notice] = 'CourseSchedule was successfully updated.'
        format.html { redirect_to(@course_schedule) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @course_schedule.errors, :status => :unprocessable_entity }
      end
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
end
