class MetaKeyFactory < MetaKey
  include Mongoid::Document
  include Mongoid::Paperclip
  extend MetaKeyModule


  def findModel(line)
    classString = line.match("##").post_match.match("=").pre_match
    classString = "MetaKey" + classString.capitalize
    clazz = classString.classify.safe_constantize
    if !clazz.nil?
      clazz.new.parse(line)
    else
      MetaKey.new.parse(line)
    end

  end

end