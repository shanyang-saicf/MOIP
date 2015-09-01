module ParseFactory

    def parse(line)
      return line
    end

    def parseFactory(header ,line)
      classString = header.capitalize + "Parser"
      clazz = classString.classify.safe_constantize
      if !clazz.nil?
        clazz = clazz.new.parse(line)
      else
        clazz = self.parse(line)
      end
      return clazz
    end

    def parseFormat(keys, samples)
      begin
        formatArray = []
        @format = FormatParser.new.parse(keys)
        samples.each do | sample |
          @sample = MockRep1DnaParser.new.parse(sample)

          formatHash = Hash[@format.zip(@sample.map {|i| i.include?(',') ? (i.split(",")) : i} )]

          formatArray << formatHash
        end
        return formatArray
      rescue
        return {}
      end

    end

end