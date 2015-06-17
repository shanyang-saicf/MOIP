class FileUpload
  include Mongoid::Document
  include Mongoid::Paperclip

  has_mongoid_attached_file :fileupload
  validates_attachment :fileupload, content_type: { content_type: ['text/directory'] }
  #do_not_validate_attachment_file_type :fileupload

  :fileupload.as_json.inspect
end
