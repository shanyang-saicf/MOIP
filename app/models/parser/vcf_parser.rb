class VcfParser
  include ParseFactory

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
            hashJson << parseLineData(data, @headers)
          end
        end
      end
    end
    hashJson
  end


  def parseLineData(data, headers)
      hashMap = {}
      count = 0
      headers.headers.each { |header|
        if (header == "FORMAT" && (!data[count].nil? || !data[count+1].nil?))
          hashMap[header] = ''
          hashMap[header] = parseFormat(data[count], data[count+1])
          count = count + 2
        else
          hashMap[header] = ''
          hashMap[header] = parseFactory(header, data[count])
          count = count + 1
        end
      }
      return hashMap
  end

  def formatKey(format, mock)
    formatHash = {}
    count = 0
    format.each do | key |
      formatHash[key] = mock[count]
      count = count + 1
    end
    formatHash
  end

end

