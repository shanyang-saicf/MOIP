class RuleUpload
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic
  include Mongoid::Paperclip

  has_mongoid_attached_file :ruleupload

  validates_attachment :ruleupload, content_type: { content_type: ['application/json'] }

  field :_id, :type => String
  field :rule, :type => Hash
  field :sentence, :type => Array


end