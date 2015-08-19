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
            count = 0
            @headers.headers.each { |header|
              hashMap[header] = ''
              hashMap[header] = parseFactory(header, data[count])
              count = count + 1
            }
            #TODO Remove!.....not generic enough!
            formatHash = {}
            count = 0
            hashMap["FORMAT"].each do | key |
              formatHash[key] = hashMap["Mock-rep1-DNA"][count]
              count = count + 1
            end
            hashMap["FORMAT"] = formatHash
            hashJson << hashMap
          end
        end
      end
    end
    hashJson
  end

end

