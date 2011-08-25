class MemberCourseInterestsController < ApplicationController
  # GET /member_course_interests
  # GET /member_course_interests.xml
  filter_access_to :all
  
  def index
    @member = Member.find(params[:member_id])
    @courses = Course.find(:all)
    @selected_interests = []
      @member.member_course_interests.each do |mci|
        @selected_interests << mci.course_id
      end
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
    @member = Member.find(params[:member_id])
    @member_course_interest = MemberCourseInterest.new(params[:membercourseinterest])

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @member_course_interest }
    end
  end

  # GET /member_course_interests/1/edit
  def edit
    @member = Member.find(params[:member_id])
    @member_course_interests = @member.member_course_interests
    @courses = Course.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @member_course_interests }
    end
  end

  # POST /member_course_interests
  # POST /member_course_interests.xml
  def create
    @member = Member.find(params[:member_id])
    @courses = Course.find(:all)
    @selected_crs_ids = []
    unless params[:crs_ids].nil?
      params[:crs_ids].each do |ci|
        @selected_crs_ids  << ci.to_s
      end
    end
    @courses.each do |crs|
      if MemberCourseInterest.find_all_by_member_id_and_course_id(@member.id, crs.id).blank?
        if @selected_crs_ids.include?(crs.id.to_s)
          @mci = MemberCourseInterest.new
          @mci.member_id = @member.id
          @mci.course_id = crs.id
          @mci.save
        end
      else
        unless @selected_crs_ids.include?(crs.id.to_s)
          MemberCourseInterest.delete_all(["member_id = ? AND course_id = ?", @member.id, crs.id] )
        end
      end
    end
    
    flash[:notice] = 'Interests saved for member ' + @member.fullname
    redirect_to members_path
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
