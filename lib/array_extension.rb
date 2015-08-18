class Array

  def squish(object=self)
    object.each do | value |
      value.squish!
    end
  end

end