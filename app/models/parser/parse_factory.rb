module ParseFactory

    def parse(line)
      return line
    end

    def parseFactory(header ,line)
      if header.include? "Mock"
        classString = header.classify.gsub('-', '_')
        classString = classString.camelize + "Parser"
        clazz = classString.safe_constantize
      else
        classString = header.capitalize + "Parser"
        clazz = classString.classify.safe_constantize
      end
      if !clazz.nil?
        clazz = clazz.new.parse(line)
      else
        clazz = self.parse(line)
      end
      return clazz
    end

end