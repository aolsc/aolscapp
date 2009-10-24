class MemberMailer < ActionMailer::Base
  def sendemail_for_members(member)
    recipients  member.emailid
    from        "abc@santaclara.com"
    subject     "Thank you for Registering"
    body        :member => member
  end
end
