class Member < ActiveRecord::Base
  has_many :member_general_feedbacks
  has_many :member_courses
  has_many :member_course_interests
end
