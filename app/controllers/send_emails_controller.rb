class SendEmailsController < ApplicationController
  add_crumb("Send Emails") { |instance| instance.send :sendemails_path }

  def index
    @members = Member.paginate :page => params[:page], :per_page => 10
    @courses = Course.find(:all)

    respond_to do |format|
      format.html
      format.xml  { render :xml => @members }
    end
  end

  def show
    @members = Member.paginate :page => params[:page], :per_page => 10
    @courses = Course.find(:all)

    respond_to do |format|
      format.html
      format.xml  { render :xml => @members }
    end
  end

  def composemessage
    @member_ids = params[:member_ids]
    respond_to do |format|
      format.html
    end
  end

  def completionstatus
    @members = Member.find(params[:member_ids])
    @email_ids = []
    @members.each do |member|
      @email_ids << member.emailid
    end
    MemberMailer.deliver_sendemail_for_members("vkorimilli@gmail.com", @email_ids, params[:subject], nil, params[:email_content])
    flash[:notice] = "Email(s) sent !"
    redirect_to :action => "searchmembers"
  end

end
