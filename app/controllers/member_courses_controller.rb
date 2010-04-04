class MemberCoursesController < ApplicationController
  add_crumb("Members") { |instance| instance.send :members_path }
  
  # GET /member_courses
  # GET /member_courses.xml
  def index
    add_crumb("Member Courses") { |instance| instance.send :member_member_courses_path }
    @course_schedules = []
    @member = Member.find(params[:member_id])
    @member_courses = MemberCourse.find(:all, :conditions => ["member_id = ?", params[:member_id]])


    if @member_courses.length == 0
    else
      for member_course in @member_courses
        @c_s = CourseSchedule.find(:all, :conditions => ["id = ? ", member_course.course_schedule_id])
        for cs in @c_s
          @course_schedules.push(cs)
        end
      end
    end
  end

  # GET /member_courses/1
  # GET /member_courses/1.xml
  def show
    add_crumb("Member Courses") { |instance| instance.send :member_member_courses_path }
    @course_schedules = []
    @member = Member.find(params[:member_id])
    @member_courses = MemberCourse.find(:all, :conditions => ["member_id = ?", params[:member_id]])
    if @member_courses.length == 0
    else
      for member_course in @member_courses
        @c_s = CourseSchedule.find(:all, :conditions => ["id = ? ", member_course.course_schedule_id])
        for cs in @c_s
          @course_schedules.push(cs)
        end
      end
    end
  end

  # GET /member_courses/new
  # GET /member_courses/new.xml
  def new
    add_crumb("Member Courses") { |instance| instance.send :member_member_courses_path }
    @member = Member.find(params[:id])
    @member_general_feedback = MemberCourse.new(params[:membercourse])

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @member_course }
    end
  end

  # GET /member_courses/1/edit
  def edit
    add_crumb("Member Courses") { |instance| instance.send :member_member_courses_path }
    @member_course = MemberCourse.find(params[:id])
  end

  # POST /member_courses
  # POST /member_courses.xml
  def create
    add_crumb("Member Courses") { |instance| instance.send :member_member_courses_path }
    @member = Member.find(params[:member_id])
    @member_course = @member.member_courses.build(params[:member_course])

    respond_to do |format|
      if @member_course.save
        flash[:notice] = 'MemberCourse was successfully created.'
        format.html { redirect_to(member_member_courses_path(@member.id))}
        format.xml  { render :xml => @member_course, :status => :created, :location => @member_course }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @member_course.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /member_courses/1
  # PUT /member_courses/1.xml
  def update
    add_crumb("Member Courses") { |instance| instance.send :member_member_courses_path }
    @member_course = MemberCourse.find(params[:id])

    respond_to do |format|
      if @member_course.update_attributes(params[:member_course])
        flash[:notice] = 'MemberCourse was successfully updated.'
        format.html { redirect_to(@member_course) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @member_course.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /member_courses/1
  # DELETE /member_courses/1.xml
  def destroy
    add_crumb("Member Courses") { |instance| instance.send :member_member_courses_path }
    @member_course = MemberCourse.find(params[:id])
    @member_course.destroy

    respond_to do |format|
      format.html { redirect_to(member_courses_url) }
      format.xml  { head :ok }
    end
  end


   def course_schedule_index
    @course_schedules = []
    @member = Member.find(params[:member_id])
    @member_courses = MemberCourse.find(:all, :conditions => ["member_id = ?", params[:member_id]])
    if @member_courses.length == 0
    else
      for member_course in @member_courses
        @c_s = CourseSchedule.find(:all, :conditions => ["id = ? ", member_course.course_schedule_id])
        for cs in @c_s
          @course_schedules.push(cs)
        end
      end
    end
  end


  def course_schedule_select
    @sel_id = params[:course][:id]
    
    @course = Course.find(@sel_id)
    @from_date = Date.civil(params[:range][:"from_date(1i)"].to_i,params[:range][:"from_date(2i)"].to_i,params[:range][:"from_date(3i)"].to_i)
    @to_date = Date.civil(params[:range][:"to_date(1i)"].to_i,params[:range][:"to_date(2i)"].to_i,params[:range][:"to_date(3i)"].to_i)
    @course_schedules = @course.course_schedules.find(:all, :conditions => ["start_date > ? AND start_date < ? ", @from_date, @to_date]).paginate :page => params[:page], :per_page => 10

    respond_to do |format|
      format.html # course_schedule_select.html.erb
      format.xml  { render :xml => @course_schedules }
    end
  end

 def course_schedule_search
   add_crumb("Attended course search")
    @courses = Course.find(:all)

    for course in @courses
      @course_schedules = CourseSchedule.find(:all, :conditions => ["course_id = ?", course.id])
    end
  end

  def course_schedule_insert
    @member_course = MemberCourse.new()
    @member_course.course_schedule_id = params[:id]
    @member_course.member_id = params[:member_id]
    @member = Member.find(params[:member_id])
    @validatecoursescheduleid = MemberCourse.find(:all, :conditions => ["course_schedule_id = ?", @member_course.course_schedule_id] )

    respond_to do |format|
    if @validatecoursescheduleid.length == 0
    @member_course.save
     flash[:notice] = "The selected schedule was successfully assigned to this member"
     format.html { redirect_to(member_member_courses_path(@member.id))}
      format.xml  { render :xml => @member_course }
    else
     flash[:notice] = "The selected Schedule was already assigned to this member"
     format.html { redirect_to(member_member_courses_path(@member.id))}
      format.xml  { render :xml => @member_course }
    end
    end

  end

end
