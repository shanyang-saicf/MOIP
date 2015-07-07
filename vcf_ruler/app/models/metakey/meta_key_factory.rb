class MetaKeyFactory < MetaKey
  include Mongoid::Document
  include Mongoid::Paperclip
  extend MetaKeyModule


  def findModel(line)
    classString = line.match("##").post_match.match("=").pre_match
    classString = "metakey" + classString.capitalize
    clazz = classString.classify.safe_constantize
    if !clazz.nil?
      clazz = clazz.new(line)
    else
      clazz = MetaKey.new(line)
    end
    return clazz
  end

end