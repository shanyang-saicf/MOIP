require 'bio-vcf/template'

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
            parsedData = parseLineData(data, @headers)
            if parsedData["ID"].is_a? Array
              parsedData = seperateComboData(parsedData)
            end
            hashJson << parsedData
          end
        end
      end
    end
    hashJson
  end


  def parseLineData(data, headers)
      hashMap = {}
      count = 0
      # data[0..8] are normal data
      # data[9..-1] are sample data for format
      headers.headers.each { |header|
        if (header == "FORMAT" && (!data[count].nil? || !data[count+1].nil?))
          hashMap[header] = ''
          hashMap[header] = parseFormat(data[count], data[count+1..-1])
        else
          hashMap[header] = ''
          hashMap[header] = parseFactory(header, data[count])
          count = count + 1
        end
      }
      return hashMap
  end

  def seperateComboData(data)
    length = data["ID"].length
  end

end

