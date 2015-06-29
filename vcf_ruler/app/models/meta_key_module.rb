module MetaKeyModule

  def is_key(line)
    if line.include? "##"
      true
    else
      false
    end
  end



end