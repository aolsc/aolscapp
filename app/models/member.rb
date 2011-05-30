class Member < ActiveRecord::Base
  has_many :member_general_feedbacks
  has_many :member_courses
  has_many :member_course_interests
  has_one :user

  def fullname
    (firstname ? firstname.capitalize : "") + " " + (lastname ? lastname.capitalize : "")
    #firstname.nil? firstname.capitalize  + " " + lastname.capitalize unless lastname.nil?
  end
end
