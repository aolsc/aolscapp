class SendEmailsController < ApplicationController
  add_crumb("Send Emails") { |instance| instance.send :sendemails_path }

  def searchmembers
    @members = Member.paginate :page => params[:page], :per_page => 10
    @courses = Course.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @members }
    end
  end

  def composemessage
    @members = Member.find(params[:member_ids])
    @members.each do |member|
      puts member.id
      MemberMailer.deliver_sendemail_for_members(member)
    end
    redirect_to :action => "completionstatus"
  end

  def completionstatus
  end

end
