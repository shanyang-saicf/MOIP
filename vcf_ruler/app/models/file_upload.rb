class FileUpload
  include Mongoid::Document
  include Mongoid::Paperclip

  has_mongoid_attached_file :fileupload


  validates_attachment :fileupload, content_type: { content_type: ['text/directory'] }

  #before_save :contents_of_file_into_body
  #do_not_validate_attachment_file_type :fileupload

  def fileupload_contents
    #p @fileupload
    #p fileupload
   #fileupload.copy_to_local_file.read
  end

end
