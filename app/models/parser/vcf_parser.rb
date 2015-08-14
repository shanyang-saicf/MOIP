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
            hashJson << hashMap
          end
        end
      end
    end
    hashJson
  end

end

