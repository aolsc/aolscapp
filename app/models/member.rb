class Member < ActiveRecord::Base
  has_many :member_general_feedbacks
  has_many :member_courses
  has_many :member_course_interests
  has_one :user
  validates_presence_of :firstname, :lastname, :emailid, :gender
  acts_as_taggable_on :tags

  def fullname
    (firstname ? firstname.capitalize : "") + " " + (lastname ? lastname.capitalize : "")
    #firstname.nil? firstname.capitalize  + " " + lastname.capitalize unless lastname.nil?
  end

  def memberphone
    unless cellphone.nil? or cellphone.blank?
      return cellphone + " (c)"
    end
    unless homephone.nil? or homephone.blank?
      return homephone + " (h)"
    end
  end

end
