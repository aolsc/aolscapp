class MemberCourseInterest < ActiveRecord::Base
  belongs_to :member
  belongs_to :course
end
