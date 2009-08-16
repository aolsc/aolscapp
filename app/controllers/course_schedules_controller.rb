class CourseSchedulesController < ApplicationController
  # GET /course_schedules
  # GET /course_schedules.xml
  def index
    @course = Course.find(params[:course_id])
    @course_schedules = @course.course_schedules

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
    @course = Course.find(params[:course_id])
    @course_schedule = @course.course_schedules.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @course_schedule }
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
    @course_schedule = @course.course_schedules.build(params[:course_schedule])

    respond_to do |format|
      if @course_schedule.save
        flash[:notice] = 'CourseSchedule was successfully created.'
        format.html { redirect_to(@course_schedule) }
        format.xml  { render :xml => @course_schedule, :status => :created, :location => @course_schedule }
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
