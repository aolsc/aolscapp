class UploadController < ApplicationController
  def index
  end

  def upload_file
    post = DataFile.save(params[:upload])
    flash[:notice] = 'File has been uploaded successfully.'
  end
end
