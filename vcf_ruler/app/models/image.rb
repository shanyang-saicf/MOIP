class Image
  include Mongoid::Document
  include Mongoid::Paperclip

  has_mongoid_attached_file :image
  validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
end
