class InfoParser < ParseFactory

  attr_accessor :infoHash

  def parse(line)
    @infoHash = {}
    infoArray = line.split(";")
    infoArray.each do | infoLine |
      if !infoLine.include? "FUNC"
        data = infoLine.split("=")
        if !data[1].nil?
           if data[1].include? ','
             data[1] = data[1].split(",")
           end
        end
        @infoHash.store(data[0], data[1])
      else
        data = infoLine.split("=[")
        json = ActiveSupport::JSON.decode(("[" + data[1]).tr('\'', '"'))
        funcHash = {}
        json[0].each { |key, value|
          funcHash.store(key, value)
        }
        @infoHash.store(data[0], funcHash)
      end
    end
    return @infoHash
  end

end