class RuleUpload
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic

  field :rule, :type => Hash

end