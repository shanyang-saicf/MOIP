class RuleUpload
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic
  include Mongoid::Paperclip

  has_mongoid_attached_file :ruleupload

  # do_not_validate_attachment_file_type :ruleupload
  validates_attachment :ruleupload, content_type: { content_type: ['application/json'] }

  field :_id, :type => String
  field :rule, :type => Hash
  field :sentence, :type => Array


end