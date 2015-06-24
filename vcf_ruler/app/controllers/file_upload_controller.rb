class FileUploadController < ApplicationController

  skip_before_filter :verify_authenticity_token

  def index
  end

  def new
  end

  def show
  end

  def create
    @fileupload = FileUpload.new( user_params )
    #@fileupload.save
    @file = Paperclip.io_adapters.for(@fileupload.fileupload).read
    p @file
    render nothing: true
  end


  private

  def user_params
    params.require(:fileupload).permit(:fileupload)
  end
end
