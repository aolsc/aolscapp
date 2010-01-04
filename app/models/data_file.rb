require 'csv'


class DataFile < ActiveRecord::Base

  def self.save( upload )
    name = upload['datafile'].original_path
    dirictory = 'public/data'
    # create the file path
    path = File.join( dirictory, name )
    data = upload['datafile'].read;
    puts '************************************************'
    #puts data;
    puts '************************************************'
    File.open(path, "wb") { |f| f.write( data ) }

    #parse file name
    courseName = name.split('_')[0]
    courseDate = name.split('_')[1]
    instructorFirstName = name.split('_')[2]

    if(!validateCourse(courseName))
      return
    end

    courseId = getCourseId(courseName)

    # Create Course Schedule
    courseScheduleId = createCourseSchedule( courseId,courseDate,instructorFirstName )

    createMembers(path, courseScheduleId)



  end

  ##
  # Function to create members and maping members to course schedules
  ##
  def self.createMembers(path, courseScheduleId)
    

    rowCount = 1
    CSV.open( path , 'r', ',') do |row|
      if rowCount > 1
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
        ];
        @member = Member.new(t)

        if( isExistingMember( @member ) )
          mapMemberToCourseSchedule(@member.id,courseScheduleId)
        else
          @member.save
          mapMemberToCourseSchedule(@member.id,courseScheduleId)
        end

      end
      rowCount = rowCount +1
    end
  end



  ##
  # Function to validate if member already exists.
  ##

  def self.isExistingMember( member )
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
  def self.mapMemberToCourseSchedule(memberId,courseScheduleId)
    t =  Hash[
      'member_id',memberId,
      'course_schedule_id',courseScheduleId,
    ];
    @member_course = MemberCourse.new(t)
    @validatecoursescheduleid = MemberCourse.find(:all, :conditions => ["course_schedule_id = ?", @member_course.course_schedule_id] )
    if @validatecoursescheduleid.length == 0
      @member_course.save
    end
  end

  ##
  # Function to validate course
  ##
  def self.validateCourse(courseName)
    @course = Course.find(:all, :conditions => ["name = ? ", courseName  ])
    if @course.length == 0
      return false
    else
      return true
    end
  end


  ##
  # Function to get Course Id
  ##
  def self.getCourseId(courseName)
    @course = Course.find(:all, :conditions => ["name = ? ", courseName  ])
    return @course[0].id
  end



  ##
  # Function to create Course scehdule
  ##

  def self.createCourseSchedule( courseId,courseDate,instructorFirstName )
    t =  Hash[
      'course_id',courseId,
      'start_date',courseDate,
      'teacher_name',instructorFirstName,
    ];
    @course_schedule = CourseSchedule.new(t)

    @course_schedule.save
    id = @course_schedule.id

    return id
  end

  


end
