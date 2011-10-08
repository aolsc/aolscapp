class Center < ActiveRecord::Base
  has_many :members
  has_many :tags
  has_many :member_attendances
  has_many :course_schedules
  validates_presence_of :city, :state

  def location
    (city ? city.camelcase : "") + ", " + (state ? state.camelcase : "")
    #firstname.nil? firstname.capitalize  + " " + lastname.capitalize unless lastname.nil?
  end

end
