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

    def parseFormat(keys, values)
      begin
        @format = FormatParser.new.parse(keys)
        @mock = MockRep1DnaParser.new.parse(values)
        formatHash = {}
        count = 0
        @format.each do | key | formatHash[key] = @mock[count]
          count = count + 1
        end
        return formatHash
      rescue
        return {}
      end

    end

end