class MemberReportController < ApplicationController
  add_crumb("Member Report") { |instance| instance.send :memberreport_path }

  def index
    @courses = Course.find(:all)
    @courseschedules = CourseSchedule.find(:all, :conditions => ["center_id = ?", session[:center_id]], :order => "start_date desc").paginate :page => params[:page], :per_page => 10
    @cs_id = -1
    @teacherusers = Role.find_by_role_name("Teacher").users
    @teachers = []
    @teacherusers.each do |tu|
      if tu.member.center.id.to_s == session[:center_id]
        @teachers << tu.member
      end
    end

    @assistantusers = Role.find_by_role_name("Volunteer").users
    @assistants = []
    @assistantusers.each do |tu|
      if tu.member.center.id.to_s == session[:center_id]
        @assistants << tu.member
      end
    end


    respond_to do |format|
      format.html
      format.xml  { render :xml => @members }
    end
  end

  def show
    @courses = Course.find(:all)

    if !params[:from_date_cal].empty?
      @report_start_date = Time.parse(params[:from_date_cal])
    end
    if !params[:end_date_cal].empty?
      @report_end_date = Time.parse(params[:end_date_cal])
    end


    @coursedd = params[:coursedd] unless params[:coursedd][:id].empty?

    @teacherusers = Role.find_by_role_name("Teacher").users
    @teachers = []
    @teacherusers.each do |tu|
      if tu.member.center.id.to_s == session[:center_id]
      @teachers << tu.member
      end
    end

    @assistantusers = Role.find_by_role_name("Volunteer").users
    @assistants = []
    @assistantusers.each do |tu|
      if tu.member.center.id.to_s == session[:center_id]
      @assistants << tu.member
      end
    end

    @teacherssel = params[:teacherssel] unless params[:teacherssel][:id].empty?
    @assistantssel = params[:assistantssel] unless params[:assistantssel][:id].empty?

    #if @report_start_date.nil? or @report_end_date.nil?
    # @courseschedules = CourseSchedule.find(:all, :conditions => ["course_id=?", params[:coursedd][:id]]).paginate :page => params[:page], :per_page => 10
    #else
    #      @courseschedules = CourseSchedule.find(:all, :conditions => ["start_date >= ? and end_date <= ? and course_id=?", @report_start_date, @report_end_date, params[:coursedd][:id]]).paginate :page => params[:page], :per_page => 10
    #   end
    @courseschedules ||= find_course_schedules.paginate :page => params[:page], :per_page => 10
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

    @cs = CourseSchedule.find(@cs_id)
    @member_attendances = @cs.member_attendances
    @email_ids = []
    @member_attendances.each_with_index do |att, i|
      unless att.member.nil?
        @eid = att.member.emailid
        unless @email_ids.include?(@eid + ",")
          if i == @member_attendances.size - 1
            @email_ids << @eid
          else
            @email_ids << @eid + ","
          end
        end
      end
    end

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

  def sendemail
    @cs_id = params[:cs_id]
    @member_courses = MemberCourse.find(:all, :conditions => ["course_schedule_id=?", @cs_id])
    @email_ids = []
    @member_courses.each do |member_course|
      if !@email_ids.include?(member_course.member.emailid)
        # MemberMailer.deliver_sendemail_for_members("santaclara@us.artofliving.org", member_course.member.emailid, params[:subject], nil, params[:email_content].gsub('{FIRSTNAME}', member_course.member.firstname))
        @email_ids << member_course.member.emailid
      end
    end

    # flash[:notice] = "Email(s) sent !"
    flash[:notice] = "Email feature is currently disabled."
    redirect_to :action => "index"
  end

  def update_course_schedules
    @courses = Course.find(params[:coursedd][:id])
    @cls = @courses.course_schedules

    render :update do |page|
      page.replace_html 'courseschedules', :partial => 'courseschedules', :object => @cls
    end
  end

  private
  def find_course_schedules
    CourseSchedule.find(:all, :conditions => conditions, :order => "start_date desc")
  end

  def id_conditions
    ["course_id = ?", params[:coursedd][:id]] unless params[:coursedd][:id].empty?
  end

 def center_conditions
    ["center_id = ?", session[:center_id]]
 end

  def teacher_conditions
    ["teacher_id = ?", params[:teacherssel][:id]] unless params[:teacherssel][:id].empty?
  end

  def assistant_conditions
    ["volunteer_id = ? or volunteer_id2 = ?", params[:assistantssel][:id], params[:assistantssel][:id]] unless params[:assistantssel][:id].empty?
  end

  def start_date_conditions
    if !params[:from_date_cal].empty?
      @report_start_date = Date.parse(params[:from_date_cal])
      ["start_date >= ?", @report_start_date]
    end
  end

  def end_date_conditions
    if !params[:end_date_cal].empty?
      @report_end_date = Date.parse(params[:end_date_cal])
      ["start_date <= ?", @report_end_date]
    end
  end

  def conditions
    [conditions_clauses.join(' AND '), *conditions_options]
  end

  def conditions_clauses
    conditions_parts.map { |condition| condition.first }
  end

  def conditions_options
    conditions_parts.map { |condition| condition[1..-1] }.flatten
  end

  def conditions_parts
    private_methods(false).grep(/_conditions$/).map { |m| send(m) }.compact
  end
end