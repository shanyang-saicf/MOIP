class HeaderKey
  include Mongoid::Document
  include Mongoid::Paperclip

  attr_accessor :headers

  def initialize
    @headers = []
  end

  def fillHeader(line)
    line_breaker(line)
  end

  private
  def line_breaker(line)
    line.match("#").post_match.split("\t").each do | header |
      header.tr("\n", "")
      headers.push(header.tr("\n", ""))
    end
  end

end