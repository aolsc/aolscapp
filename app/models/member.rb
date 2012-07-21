class Member < ActiveRecord::Base
  has_many :member_courses
  has_many :member_taggings
  has_many :member_attendances
  has_many :communication_subscriptions
  has_many :member_connections
  has_many :member_notes, :order => "created_at DESC"

  has_one :user
  belongs_to :center
  validates_presence_of :firstname, :lastname, :emailid, :center_id
  validates_inclusion_of :taken_course, :in => [true, false], :message => " - Please select if you have taken Art of Living Course"
  validates_uniqueness_of :emailid

  def fullname
    (firstname ? firstname.capitalize : "") + " " + (lastname ? lastname.capitalize : "")
    #firstname.nil? firstname.capitalize  + " " + lastname.capitalize unless lastname.nil?
  end

  def fullname_with_role
    (firstname ? firstname.capitalize : "") + " " + (lastname ? lastname.capitalize : "") + " (" + user.highest_role + ") - " +  center.city
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


  def contact_html
    @contact =""
    unless cellphone.nil? or cellphone.blank?
      @contact = "<b>(c)</b> " + cellphone
    end
    unless homephone.nil? or homephone.blank?
      @contact = @contact + "<br><b>(h)</b> " + homephone
    end
    @contact = @contact + "<br>" + emailid
    return @contact
  end

  def has_taken
    unless taken_course.nil?
      if taken_course?
        return "Yes"
      end
        return "No"
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
