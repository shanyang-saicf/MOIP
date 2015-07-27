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
              parseFactory(header, data[count])
              count + 1
            }

            # hashMap['CHROM'] = data[0]
            # hashMap['POS'] = data[1]
            # hashMap['ID'] = data[2]
            # hashMap['REF'] = data[3]
            # hashMap['ALT'] = data[4]
            # hashMap['QUAL'] = data[5]
            # hashMap['FILTER'] = data[6]
            # if !data[7].nil?
            #   infoHash = {}
            #   infoArray = data[7].split(";")
            #   infoArray.each do | infoLine |
            #     if !infoLine.include? "FUNC"
            #       data = infoLine.split("=")
            #       infoHash.store(data[0], data[1])
            #     else
            #       data = infoLine.split("=[")
            #       json = ActiveSupport::JSON.decode(("[" + data[1]).tr('\'', '"'))
            #       funcHash = {}
            #       json[0].each { |key, value|
            #         funcHash.store(key, value)
            #       }
            #       infoHash.store(data[0], funcHash)
            #     end
            #   end
            # end
            # hashMap['INFO'] = infoHash
            # hashMap['FORMAT'] = data[8]
            # hashMap['Mock_rep1_DNA'] = data[9]
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
    classString = header.capitalize + "Parser"
    clazz = classString.classify.safe_constantize
    p clazz
    if !clazz.nil?
      clazz = clazz.new.parse(line)
    else
      #clazz = self.parse(line)
    end
    return clazz
  end

end