class RecurringEventsController < ApplicationController
  # GET /course_schedules
  # GET /course_schedules.xml
  def index
    @course = Course.find(params[:course_id])
    @recurring_events = RecurringEvent.find(:all, :conditions => ["center_id = ? and course_id=?", session[:center_id], @course.id])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @recurring_events }
    end
  end

  # GET /course_schedules/1
  # GET /course_schedules/1.xml
  def show
    @recurring_event = RecurringEvent.find(params[:id])
    @course = Course.find(params[:course_id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @recurring_event }
    end
  end

  # GET /course_schedules/new
  # GET /course_schedules/new.xml
  def new
    @course = Course.find(params[:id])
    @recurring_event = RecurringEvent.new(params[:recurring_event])
  end

  # GET /course_schedules/1/edit
  def edit
    @recurring_event = RecurringEvent.find(params[:id])
    @course = @recurring_event.course

    @start_date = @recurring_event.start_date
  end

  # POST /course_schedules
  # POST /course_schedules.xml
  def create
    @course = Course.find(params[:course_id])
    @recurring_event = RecurringEvent.new
    @recurring_event.course_id = params[:course_id]
    @recurring_event.start_date = Time.parse(params[:start_date])

    @recurring_event.center_id = session[:center_id]
      if @recurring_event.save
        flash[:notice] = 'CourseSchedule was successfully created.'
        redirect_to(course_recurring_events_path(@course.id))
      else
        flash[:notice] = 'Could not create recurring event due to system errors.'
        redirect_to course_recurring_events_path(@course.id)
      end
  end

  # PUT /course_schedules/1
  # PUT /course_schedules/1.xml
  def update
    @recurring_event = RecurringEvent.find(params[:id])

    @recurring_event.start_date = Time.parse(params[:start_date])
    @course = @recurring_event.course
    @re = RecurringEvent.find(:first, :conditions => ["center_id = ? and start_date = ? and course_id=?", session[:center_id],Time.parse(params[:start_date]).to_time.utc, @course.id])
      if !@re.nil? and @re.id != @recurring_event.id
        flash[:notice] = 'Could not create recurring event. A recurring event with the same start date, for this recurring event already exists.'
        redirect_to course_recurring_events_path(@course.id)
      elsif @recurring_event.save
        flash[:notice] = 'RecurringEvent was successfully updated.'
        redirect_to course_recurring_events_path(@course.id)
      else
        flash[:notice] = 'Could not create recurring event due to system errors.'
        redirect_to course_recurring_events_path(@course.id)
      end

  end

  # DELETE /course_schedules/1
  # DELETE /course_schedules/1.xml
  def destroy
    @recurring_event = RecurringEvent.find(params[:id])
    @recurring_event.destroy

    respond_to do |format|
      format.html { redirect_to(recurring_events_url) }
      format.xml  { head :ok }
    end
  end

end
