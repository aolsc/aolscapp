class SendEmailsController < ApplicationController
  add_crumb("Send Emails") { |instance| instance.send :sendemails_path }

  def index
    @courses = Course.find(:all)
    @courseschedules = CourseSchedule.paginate :page => params[:page], :per_page => 10
    @cs_id = -1

    respond_to do |format|
      format.html
      format.xml  { render :xml => @members }
    end
  end

  def show
    @courses = Course.find(:all)
      @report_start_date = build_date_from_params("from_date", params[:range])
      @report_end_date = build_date_from_params("to_date", params[:range])
      @coursedd = params[:coursedd]
      @range = params[:range]
      puts @range
      if @report_start_date.nil? or @report_end_date.nil?
        @courseschedules = CourseSchedule.find(:all, :conditions => ["course_id=?", params[:coursedd][:id]]).paginate :page => params[:page], :per_page => 10
      else
        @courseschedules = CourseSchedule.find(:all, :conditions => ["start_date >= ? and end_date <= ? and course_id=?", @report_start_date, @report_end_date, params[:coursedd][:id]]).paginate :page => params[:page], :per_page => 10
    end
    @cs_id = -1

    respond_to do |format|
      format.html
      format.xml  { render :xml => @members }
    end
  end

  def build_date_from_params(field_name, params)
    if params["#{field_name.to_s}(1i)"].empty?
      return
    else
      puts "no"
      Date.new(params["#{field_name.to_s}(1i)"].to_i,
       params["#{field_name.to_s}(2i)"].to_i,
       params["#{field_name.to_s}(3i)"].to_i)
    end
  end

  def composemessage
    
    puts params[:course_schedule_radio]
    @cs_id = params[:course_schedule_radio]
    
    respond_to do |format|
      format.html
    end

  end

  def confirmmembers
    @cs_id = params[:cs_id]
    @member_courses = MemberCourse.find(:all, :conditions => ["course_schedule_id=?", @cs_id])
    @email_ids = []
    @member_courses.each do |member_course|
      @email_ids << member_course.member.emailid
    end

    puts @email_ids
    puts @cs_id
    respond_to do |format|
      format.html
    end
  end

  def completionstatus
    @cs_id = params[:cs_id]
    @member_courses = MemberCourse.find(:all, :conditions => ["course_schedule_id=?", @cs_id])
    @email_ids = []
    @member_courses.each do |member_course|
      @email_ids << member_course.member.emailid
    end

    puts @email_ids
    
    flash[:notice] = "Email(s) sent !"
    redirect_to :action => "index"
  end

  def update_course_schedules
    @courses = Course.find(params[:coursedd][:id])
    @cls = @courses.course_schedules

    render :update do |page|
      page.replace_html 'courseschedules', :partial => 'courseschedules', :object => @cls
    end
  end
 end