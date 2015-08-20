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
            # ["CHROM", "POS", "ID", "REF", "ALT", "QUAL", "FILTER", "INFO", "FORMAT", "Mock-rep1-DNA"]
            # if (hashMap["ID"].is_a? Array) && (hashMap["ALT"].is_a? Array)
            #   hashMap["ID"].zip(hashMap["ALT"]).each do | singleVariant |
            #     variant = {}
            #     @headers.headers.each { |header|
            #       variant[header] = hashMap[header]
            #       variant["ID"] = singleVariant[0]
            #       variant["ALT"] = singleVariant[1]
            #     }
            #     variant["FORMAT"] = formatKey(hashMap["FORMAT"], hashMap["Mock-rep1-DNA"])
            #     hashJson << variant
            #   end
            # else
            #   hashMap["FORMAT"] = formatKey(hashMap["FORMAT"], hashMap["Mock-rep1-DNA"])
            #   hashJson << hashMap
            # end
            #TODO Remove!.....not generic enough!
            # formatHash = {}
            # count = 0
            # hashMap["FORMAT"].each do | key |
            #   formatHash[key] = hashMap["Mock-rep1-DNA"][count]
            #   count = count + 1
            # end
            # hashMap["FORMAT"] = formatHash
            hashJson << hashMap
          end
        end
      end
    end
    hashJson
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

