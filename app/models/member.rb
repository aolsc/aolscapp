class Member < ActiveRecord::Base
  has_many :member_courses
  has_many :member_taggings
  has_one :user
  validates_presence_of :firstname, :lastname, :emailid
  validates_presence_of :taken_course, :message => " - Please select if you have taken Art of Living Course"

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

  def tags_list
    tags = []
    member_taggings.each do |mt|
      tags << mt.tag.name
    end
    return tags
  end

end
