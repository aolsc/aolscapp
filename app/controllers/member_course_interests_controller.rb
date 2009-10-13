class MemberCourseInterestsController < ApplicationController
  # GET /member_course_interests
  # GET /member_course_interests.xml
  def index
    @member = Member.find(params[:member_id])
    @member_course_interests = @member.member_course_interests

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @member_course_interests }
    end
  end

  # GET /member_course_interests/1
  # GET /member_course_interests/1.xml
  def show
    @member_course_interest = MemberCourseInterest.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @member_course_interest }
    end
  end

  # GET /member_course_interests/new
  # GET /member_course_interests/new.xml
  def new
    @courses = Course.find(:all)
    @member = Member.find(params[:id])
    @member_course_interest = MemberCourseInterest.new(params[:membercourseinterest])

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @member_course_interest }
    end
  end

  # GET /member_course_interests/1/edit
  def edit
    @member_course_interest = MemberCourseInterest.find(params[:id])
  end

  # POST /member_course_interests
  # POST /member_course_interests.xml
  def create
    @member = Member.find(params[:member_id])
    @member_course_interest = @member.member_course_interests.build(params[:member_course_interest])
    @member_course_interest.course_id = params[:course][:id]

    respond_to do |format|
      if @member_course_interest.save
        flash[:notice] = 'MemberCourseInterest was successfully created.'
        format.html { redirect_to(member_member_course_interests_path(@member.id))}
        format.xml  { render :xml => @member_course_interest, :status => :created, :location => @member_course_interest }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @member_course_interest.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /member_course_interests/1
  # PUT /member_course_interests/1.xml
  def update
    @member_course_interest = MemberCourseInterest.find(params[:id])

    respond_to do |format|
      if @member_course_interest.update_attributes(params[:member_course_interest])
        flash[:notice] = 'MemberCourseInterest was successfully updated.'
        format.html { redirect_to(@member_course_interest) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @member_course_interest.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /member_course_interests/1
  # DELETE /member_course_interests/1.xml
  def destroy
    @member_course_interest = MemberCourseInterest.find(params[:id])
    @member_course_interest.destroy

    respond_to do |format|
      format.html { redirect_to(member_course_interests_url) }
      format.xml  { head :ok }
    end
  end
end
