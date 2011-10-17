  require 'csv'

class UploadController < ApplicationController
  attr_reader :mc, :mu, :me

  def index
  @courses = Course.find(:all)

  @coursesel = params[:coursesel]
  @teacherssel = params[:teacherssel]
  @assistantssel1 = params[:assistantssel1]

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
  unless params[:mode].nil?
    @mode = params[:mode]
    render :layout => "signup"
  end
  end

  def upload_file
    if params[:coursesel][:id].empty?
      flash[:notice] = 'Please select a course'
      redirect_to params.merge!(:action => :index)
    elsif params[:start_date].empty?
      flash[:notice] = 'Please choose a start date'
      redirect_to params.merge!(:action => :index)
    elsif params[:teacherssel][:id].empty?
      flash[:notice] = 'Please select a teacher'
      redirect_to params.merge!(:action => :index)
    elsif params[:assistantssel1][:id].empty?
      flash[:notice] = 'Please select an assistant'
      redirect_to params.merge!(:action => :index)
    elsif params[:upload].nil?
      flash[:notice] = 'Please select a file to upload'
      redirect_to params.merge!(:action => :index)
    else
      courseName = Course.find(params[:coursesel][:id]).name
      courseScheduleId = getOrCreateCourseSched( params[:coursesel][:id],Time.parse(params[:start_date]).to_time.utc,params[:teacherssel][:id],params[:assistantssel1][:id],params[:assistantssel2][:id] )
      @mc = 0
      @mu = 0
      @me = 0
      save(params[:upload], courseScheduleId, courseName)
      flash.now[:notice] = "File has been uploaded.<br><br>Number of new members created - " + @mc.to_s + "<br>Number of existing members updated - " + @mu.to_s+ "<br>Number of new members could not be uploaded due to errors - " + @me.to_s
    end
  rescue CustomException::WrongFileFormat
    flash[:notice] = 'The uploaded file does not belong to the Course chosen. Please verify.'
    CourseSchedule.delete(courseScheduleId)
    redirect_to :action => "index"
  end

 def getOrCreateCourseSched ( courseId,courseDate,teacherId, assistantId, assistantId2)
    @cs = CourseSchedule.find(:first, :conditions => ["start_date = ? and course_id=? and teacher_id=?", courseDate, courseId, teacherId])
    if @cs.nil?
      t =  Hash[
        'course_id',courseId,
        'start_date',courseDate,
        'teacher_id',teacherId,
        'volunteer_id',assistantId,
        'last_updated_by',current_user[:id],
        'volunteer_id2',assistantId2,
        'center_id',session[:center_id]
      ];

      @course_schedule = CourseSchedule.new(t)

      @course_schedule.save
      id = @course_schedule.id
      puts "created cs "
      return id
    else
      @cs.last_updated_by = current_user[:id]
      @cs.center_id = session[:center_id]
      @cs.save
      return @cs.id
    end
  end

  def save( upload, courseScheduleId, courseName )
    name = upload['datafile'].original_path
    dirictory = 'public/data'
    # create the file path
    path = File.join( dirictory, name )
    data = upload['datafile'].read;
    puts 'NAME ********' + name
    #puts data;
    puts '***'
    File.open(path, "wb") { |f| f.write( data ) }

    if name.eql?("attended.csv")
      createAttendedMembers(path, courseScheduleId)
    else
      createMembers(path, courseScheduleId, courseName)
    end
    
  end

  def createAttendedMembers(path, courseScheduleId)
      CSV.open( path , 'r', ',') do |row|
          if !row[0].nil? and !row[0].empty?
            t =  Hash[
              'firstname',row[0].split(' ')[0],
              'lastname',row[0].split(' ')[1],
              'emailid',row[1],
              'homephone',row[2],
              'updateby',current_user[:id],
               'center_id',session[:center_id],
              'taken_course',0
            ];
            @member = Member.new(t)

            if( isExistingMember( @member ) )
              @mu += 1
              mapMemberToCourseSchedule(@member.id,courseScheduleId, '')
            else
              @member.center_id = session[:center_id]
              @member.save
              @mc += 1
              mapMemberToCourseSchedule(@member.id,courseScheduleId, '')
            end
            a =  Hash[
              'course_schedule_id',courseScheduleId,
              'member_id',@member.id,
            ];
            @member_attendance = MemberAttendance.new(a)
            @ma_check = MemberAttendance.find(:all, :conditions => ["member_id = ? AND course_schedule_id = ?", @member.id, courseScheduleId])
            if @ma_check.length == 0
              @member_attendance.center_id = session[:center_id]
              @member_attendance.save
            end
          end
        end
  end


  # Function to create members and maping members to course schedules
  ##
  def createMembers(path, courseScheduleId, courseName)
    if courseName.eql?("mbw")
      rowCount = 0
      CSV.open( path , 'r', ',') do |row|
        if rowCount == 1 and !row[1].eql?("Address1")
          puts "row 1 "
          puts row[1]
          raise CustomException::WrongFileFormat
        end

        if rowCount > 1
          if !row[0].nil? and !row[0].empty?
            t =  Hash[
              'firstname',row[0].split(' ')[0],
              'lastname',row[0].split(' ')[1],
              'address1',row[1],
              'address2',row[2],
              'city',row[3],
              'state',row[4],
              'zip',row[5],
              'country',row[6],
              'emailid',row[8],
              'homephone',row[9],
              'updateby',current_user[:id],
              'center_id',session[:center_id],
              'taken_course',0
            ];
            @member = Member.new(t)

            if isExistingMember( @member )
              @mu += 1
              mapMemberToCourseSchedule(@member.id,courseScheduleId, row[7])
            else
               @member.center_id = session[:center_id]
              if @member.save
                @mc += 1
              else
                @me += 1
              end
              mapMemberToCourseSchedule(@member.id,courseScheduleId, row[7])
            end

         end
        end
        rowCount = rowCount +1
      end
    else if courseName.eql?('part1')
      rowCount = 0
      CSV.open( path , 'r', ',') do |row|

        if rowCount == 1 and !row[1].eql?('Gender')
          raise CustomException::WrongFileFormat
        end

        if rowCount > 1
          if !row[0].nil? and !row[0].empty?
            t =  Hash[
              'firstname',row[0].split(' ')[0],
              'lastname',row[0].split(' ')[1],
              'gender', row[1],
              'address1',row[2],
              'city',row[3],
              'state',row[4],
              'zip',row[5],
              'emailid',row[6],
              'homephone',row[23],
              'cellphone',row[25],
              'updateby',current_user[:id],
              'center_id',session[:center_id],
              'taken_course',0
            ];
            @member = Member.new(t)

            if( isExistingMember( @member ) )
              @mu += 1
              mapMemberToCourseSchedule(@member.id,courseScheduleId, row[30])
            else
               @member.center_id = session[:center_id]
              if @member.save
                @mc += 1
              else
                @me += 1
              end
              mapMemberToCourseSchedule(@member.id,courseScheduleId, row[30])
            end
          end
        end
        rowCount = rowCount +1
      end
    end
  end
  end
  



  ##
  # Function to validate if member already exists.
  ##

  def isExistingMember( member )
    #Validate if member already exists

    @validatemember = Member.find(:all, :conditions => ["firstname = ? AND lastname = ? AND emailid = ?", member.firstname, member.lastname, member.emailid
      ])
    if @validatemember.length == 0
      return false
    else
       member.id = @validatemember[0].id
      return true
    end

  end

  ##
  # Function to map members to course schedule.
  ##
  def mapMemberToCourseSchedule(memberId,courseScheduleId,source)
    t =  Hash[
      'member_id',memberId,
      'course_schedule_id',courseScheduleId,
      'referral_source',source,
      'last_updated_by', current_user[:id],
    ];
    @member_course = MemberCourse.new(t)
    @validatecoursescheduleid = MemberCourse.find(:all, :conditions => ["member_id=? and course_schedule_id = ?", @member_course.member_id, @member_course.course_schedule_id] )
    if @validatecoursescheduleid.length == 0 or @validatecoursescheduleid.empty?
      @member_course.save
    end
  end




end