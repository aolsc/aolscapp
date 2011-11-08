class Course < ActiveRecord::Base
  has_many :course_schedules
  has_many :recurring_events
end
