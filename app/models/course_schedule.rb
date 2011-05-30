class CourseSchedule < ActiveRecord::Base
  belongs_to :course
  has_many :member_courses
  has_many :member_attendances
  belongs_to :assistant, :class_name => 'Member', :foreign_key => 'volunteer_id'
  belongs_to :teacher, :class_name => 'Member', :foreign_key => 'teacher_id'
  belongs_to :assistant2, :class_name => 'Member', :foreign_key => 'volunteer_id2'
end
