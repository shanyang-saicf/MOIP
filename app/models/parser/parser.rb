class Parser

  def fileParse(file)
    @metaClass = MetaKeyFactory.new
    @headers = HeaderKey.new

    hashJson = []
    begin
      File.open(file.path).each do |line|
        if MetaKeyFactory.is_key(line)
          @metaClass.findModel(line)
        elsif MetaKeyFactory.is_header(line)
          @headers.fillHeader(line)
        else
          hashMap = {}
          data = line.split("\t")
          if @headers.headers.length == data.length
            count = 0
            @headers.headers.each { |header|
              hashMap[header] = ''
              hashMap[header] = parseFactory(header, data[count])
              count = count + 1
            }
            hashJson << hashMap
          end
        end
      end
    end
    hashJson
  end

  def parse(line)
    return line
  end

  def parseFactory(header ,line)
    if header.include? "Mock"
     classString = header.classify.gsub('-', '_')
     classString = classString.camelize + "Parser"
     clazz = classString.safe_constantize
    else
      classString = header.capitalize + "Parser"
      clazz = classString.classify.safe_constantize
    end
    if !clazz.nil?
      clazz = clazz.new.parse(line)
    else
      clazz = self.parse(line)
    end
    return clazz
  end

end