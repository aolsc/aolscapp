class CentersController < ApplicationController
  add_crumb("Centers") { |instance| instance.send :centers_path }
  filter_access_to :all

  # GET /courses
  # GET /courses.xml
  def index
    @centers = Center.paginate :page => params[:page], :per_page => 10

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @centers }
    end
  end

  # GET /courses/1
  # GET /courses/1.xml
  def show
    @center = Center.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @center }
    end
  end

  # GET /courses/new
  # GET /courses/new.xml
  def new
    @center = Center.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @center }
    end
  end

  # GET /courses/1/edit
  def edit
    @center  = Center.find(params[:id])
  end

  # POST /courses
  # POST /courses.xml
  def create
    @center = Center.new(params[:center])
    
    respond_to do |format|
      if @center.save
        flash[:notice] = 'Tag was successfully created.'
        format.html { redirect_to centers_path }
        format.xml  { render :xml => @center, :status => :created, :location => @center }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @center.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /courses/1
  # PUT /courses/1.xml
  def update
    @center = Center.find(params[:id])

    respond_to do |format|
      if @center.update_attributes(params[:center])
        flash[:notice] = 'Tag was successfully updated.'
        format.html { redirect_to(centers_path) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @center.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.xml
  def destroy
    @center = Center.find(params[:id])
    @center.destroy

    respond_to do |format|
      format.html { redirect_to(centers_url) }
      format.xml  { head :ok }
    end
  end
end
