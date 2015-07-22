module MetaKeyModule

  def is_key(line)
    if line.include? "##"
      true
    else
      false
    end
  end

  def is_header(line)
    if (!line.include? "##") && (line.include? "#")
      true
    else
      false
    end
  end

  def line_formatter(line)
    formattedLine = line.match("<").post_match.match(">").pre_match
    formattedLine.split(',')
  end

end