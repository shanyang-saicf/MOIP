require 'csv'

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
    @file = Paperclip.io_adapters.for(@fileupload.fileupload)
    hashMap = []
    begin
      File.open(@file.path).each do |line|
        if MetaKeyFactory.is_key(line)
          MetaKeyFactory.new.findModel(line)
        end
          #hashmap.store(MetaKey.new(line))

        #line.split("\t").each do | word |
          #p word
        #end
      end
    end
    #fileData = File.open(@file.path).read
    #p fileData
    render nothing: true
  end


  private

  def user_params
    params.require(:fileupload).permit(:fileupload)
  end

end
