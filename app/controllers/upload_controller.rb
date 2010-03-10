class UploadController < ApplicationController
  def index
  end

  def upload_file
    post = DataFile.save(params[:upload])
    flash[:notice] = 'File has been uploaded successfully.'
  rescue CustomException::CourseNotFound
    flash[:notice] = 'The course not found. Please verify file name.'
    redirect_to :action => "index"
  end
end
