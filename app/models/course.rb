class Course < ActiveRecord::Base
  has_many :course_schedules
  has_many :recurring_events

  def self.all_cached
    Rails.cache.fetch('Course.all') { all }
  end
end
