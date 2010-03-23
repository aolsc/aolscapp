class CourseSchedule < ActiveRecord::Base
  belongs_to :course
  has_many :member_courses
  belongs_to :assistant, :class_name => 'Member', :foreign_key => 'volunteer_id'
  belongs_to :teacher, :class_name => 'Member', :foreign_key => 'teacher_id'
end
