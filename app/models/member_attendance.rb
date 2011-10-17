class MemberAttendance < ActiveRecord::Base
  belongs_to :member
  belongs_to :course_schedule
  belongs_to :center
  
  def email_id
    member.emailid if member
  end

  def email_id=(email)
    self.member = Member.find_by_emailid(email) unless email.blank?
  end
end
