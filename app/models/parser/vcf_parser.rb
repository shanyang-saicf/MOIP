require 'bio-vcf/template'

class VcfParser
  include BioVcf
  include Bio
  include ParseFactory

  def fileParse(file)
    # @metaClass = MetaKeyFactory.new
    # @headers = HeaderKey.new

    hashJson = []
    template = Bio::Template.new("./public/templates/vcf2json.erb")
    begin
      header = VcfHeader.new
      File.open(file.path).each do |line|
        if line =~ /^##/
          header.add(line)
          next
        end
        # p header.lines
        fields = VcfLine.parse(line)
        rec = VcfRecord.new(fields,header)

        parsedHash = {}
        parsedHash[:CHROM] = rec.chrom
        parsedHash[:POS] = rec.pos
        parsedHash[:ID] = rec.id
        parsedHash[:REF] = rec.ref
        parsedHash[:ALT] = rec.alt[0]
        parsedHash[:QUAL] = rec.qual
        parsedHash[:FILTER] = rec.filter
        # p header.samples.size
        # if !rec.missing_samples?
        #   rec.each_sample do | s |
        #     p s
        #   end
        # end
        parsedHash[:INFO] = rec.info
        # parsedHash[:FORMAT] = rec.format.each

        hashJson << parsedHash

        # if MetaKeyFactory.is_key(line)
        #   @metaClass.findModel(line)
        # elsif MetaKeyFactory.is_header(line)
        #   @headers.fillHeader(line)
        # else
        #   hashMap = {}
        #   data = line.split("\t")
        #   if @headers.headers.length == data.length
        #     hashJson << parseLineData(data, @headers)
        #   end
        # end
        # template.header(binding)
        # p template.body(binding)
        # p template
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

