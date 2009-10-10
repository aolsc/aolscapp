class MemberCourse < ActiveRecord::Base
  belongs_to :member
  belongs_to :member_course_schedule
end
