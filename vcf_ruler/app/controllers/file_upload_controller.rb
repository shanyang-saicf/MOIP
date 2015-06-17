class FileUploadController < ApplicationController
  def index
  end

  def new
  end

  def show
  end

  def create
    @fileupload = FileUpload.new( user_params )
    if @fileupload.save
      redirect_to :action => :show, :id => @fileupload.id
    end
  end


  private

  def user_params
    params.require(:fileupload).permit(:fileupload)
  end
end
