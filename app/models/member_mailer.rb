class MemberMailer < ActionMailer::Base
  def sendemail_for_members(from, to, subject, selection_option, content)
    recipients  to
    from        from
    subject     subject
    body        content
  end
end
