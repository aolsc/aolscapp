class SendEmailsController < ApplicationController
  add_crumb("Send Emails") { |instance| instance.send :sendemails_path }

  def index
    @members = Member.paginate :page => params[:page], :per_page => 10
    @courses = Course.find(:all)
    @cls = CourseSchedule.find(:all)

     
    respond_to do |format|
      format.html
      format.xml  { render :xml => @members }
    end
  end

  def show
    @members = Member.paginate :page => params[:page], :per_page => 10
    @courses = Course.find(:all)
    @cls = CourseSchedule.find(:all)

    @id = params[:courseschedule][:id]
    puts "********************************************************************"
    puts @id

    @member_courses = MemberCourse.find_all_by_course_schedule_id(@id)

    @members = []
    if @member_courses.length != 0
       for member_course in @member_courses
         @m = Member.find(:all, :conditions => ["id = ?", member_course.member_id ])
         for m in @m
           @members.push(m)
         end
      end
    end

     for m in @members
       m.firstname
     end
    
    respond_to do |format|
      format.html
      format.xml  { render :xml => @members }
    end
  end

  def composemessage
    @member_ids = params[:member_ids]
    respond_to do |format|
      format.html
    end
  end

  def completionstatus
    @members = Member.find(params[:member_ids])
    @email_ids = []
    @members.each do |member|
      @email_ids << member.emailid
    end
    MemberMailer.deliver_sendemail_for_members("vkorimilli@gmail.com", @email_ids, params[:subject], nil, params[:email_content])
    flash[:notice] = "Email(s) sent !"
    redirect_to :action => "searchmembers"
  end

  def update_course_schedules
  
    @courses = Course.find(params[:coursedd][:id])
    @cls = @courses.course_schedules


    render :update do |page|
      page.replace_html 'courseschedules', :partial => 'courseschedules', :object => @cls
    end
  end

end
