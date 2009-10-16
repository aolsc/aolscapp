namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    require 'populator'
    require 'faker'

    @genders = ["M","F"]
    @cities = ["Santa Clara", "Sunnyvale", "Milpitas", "Mountain View", "San Jose", "San Fransisco", "Palo Alto"]
    @course_names = ["Part-1", "MBW", "AG-1", "AG-2", "AG-3","Art Excel"]
    @teachers = ["Uma", "Sridhar", "Ramesh", "Sudarshan"]
    @course_ids = []
    @feedbacks = ["The MBW was awesome!", "I feel so calm after the session", "The session was very good."]

    [Course, Member, CourseSchedule, MemberCourse, MemberCourseInterest, MemberGeneralFeedback, User].each(&:delete_all)

    @i = 0
    Course.populate 6 do |course|
      course.name = @course_names[@i]
      course.displayName = @course_names[@i]

      CourseSchedule.populate 100 do |courseschedule|
        courseschedule.course_id = course.id
        @course_ids << course.id
        courseschedule.teacher_name = @teachers.rand.to_s
        courseschedule.start_date = 2.years.ago..Time.now
        courseschedule.end_date = 2.years.ago..Time.now
      end
      @i = @i + 1
    end


    Member.populate 100 do |member|
      member.firstname    = Faker::Name.first_name
      member.lastname = Faker::Name.last_name
      member.emailid = Faker::Internet.email
      member.gender  = @genders.rand.to_s
      member.address1   = Faker::Address.street_address
      member.city  = @cities.rand.to_s
      member.state    = 'CA'
      member.zip = Faker::Address.zip_code
      member.homephone     = Faker::PhoneNumber.phone_number
      member.cellphone     = Faker::PhoneNumber.phone_number
      member.employer     = Faker::Company.name
      member.profession = Faker::Company.bs

      MemberCourse.populate 4 do |membercourse|
        membercourse.member_id = member.id
        membercourse.course_schedule_id = 1..600
      end

      MemberCourseInterest.populate 2 do |membercourseinterest|
        membercourseinterest.member_id = member.id
        membercourseinterest.course_id = @course_ids.rand.to_i
        membercourseinterest.interest_date = 6.months.ago..Time.now
      end

      MemberGeneralFeedback.populate 2 do |membergeneralfeedback|
        membergeneralfeedback.member_id = member.id
        membergeneralfeedback.feedback = @feedbacks.rand.to_s
        membergeneralfeedback.feedback_date = 6.months.ago..Time.now
      end
      
    end
  end
end