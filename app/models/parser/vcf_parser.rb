require 'bio-vcf/template'

class VcfParser
  include BioVcf
  include ParseFactory

  def fileParse(file)
    @metaClass = MetaKeyFactory.new
    @headers = HeaderKey.new

    hashJson = []
    begin
      # header = VcfHeader.new(true)
      File.open(file.path).each do |line|
        # if line =~ /^##/
        #   header.add(line)
        #   next
        # end
        # fields = VcfLine.parse(line)
        # rec = VcfRecord.new(fields,header)
        #
        #
        #
        # acutalSamples = fields[9..-1]
        # acutalSamples.each do | sample |
        # end
        # count = 0
        # rec.ids.each do | id |
        #   parsedHash = {}
        #   parsedHash[:CHROM] = rec.chrom
        #   parsedHash[:POS] = rec.pos
        #   parsedHash[:ID] = id
        #   parsedHash[:REF] = rec.ref
        #   parsedHash[:ALT] = rec.alt[count]
        #   count = count + 1
        #   parsedHash[:QUAL] = rec.qual
        #   parsedHash[:FILTER] = rec.filter
        #   parsedHash[:INFO] = rec.info
        #   parsedHash[:FORMAT] = rec.format
        #   hashJson << parsedHash
        # end

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
        if (header == "FORMAT" && (!data[count].nil? || !data[count+1..-1].nil?))
          hashMap[header] = ''
          hashMap[header] = parseFormat(data[count], data[count+1..-1])
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

