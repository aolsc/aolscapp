class MemberGeneralFeedbacksController < ApplicationController
  # GET /member_general_feedbacks
  # GET /member_general_feedbacks.xml
  def index
    @member = Member.find(params[:member_id])
    @member_general_feedbacks = @member.member_general_feedbacks

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @member_general_feedbacks }
    end
  end

  # GET /member_general_feedbacks/1
  # GET /member_general_feedbacks/1.xml
  def show
    @member_general_feedback = MemberGeneralFeedback.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @member_general_feedback }
    end
  end

  # GET /member_general_feedbacks/new
  # GET /member_general_feedbacks/new.xml
  def new
    @member = Member.find(params[:id])
    @member_general_feedback = MemberGeneralFeedback.new(params[:courseschedule])

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @member_general_feedback }
    end
  end

  # GET /member_general_feedbacks/1/edit
  def edit
    @member_general_feedback = MemberGeneralFeedback.find(params[:id])
  end

  # POST /member_general_feedbacks
  # POST /member_general_feedbacks.xml
  def create
    @member = Member.find(params[:member_id])
    @member_general_feedback = @member.member_general_feedbacks.build(params[:member_general_feedback])

    respond_to do |format|
      if @member_general_feedback.save
        flash[:notice] = 'MemberGeneralFeedback was successfully created.'
        format.html { redirect_to(member_member_general_feedbacks_path(@member.id))}
        format.xml  { render :xml => @member_general_feedback, :status => :created, :location => @member_general_feedback }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @member_general_feedback.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /member_general_feedbacks/1
  # PUT /member_general_feedbacks/1.xml
  def update
    @member_general_feedback = MemberGeneralFeedback.find(params[:id])

    respond_to do |format|
      if @member_general_feedback.update_attributes(params[:member_general_feedback])
        flash[:notice] = 'MemberGeneralFeedback was successfully updated.'
        format.html { redirect_to(@member_general_feedback) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @member_general_feedback.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /member_general_feedbacks/1
  # DELETE /member_general_feedbacks/1.xml
  def destroy
    @member_general_feedback = MemberGeneralFeedback.find(params[:id])
    @member_general_feedback.destroy

    respond_to do |format|
      format.html { redirect_to(member_general_feedbacks_url) }
      format.xml  { head :ok }
    end
  end
end
