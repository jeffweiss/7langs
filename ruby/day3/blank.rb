class NilClass
  def blank?
    true
  end
end

class String
  def blank?
    self.strip.size == 0
  end
end

[" ", "person", nil].each { |element| puts element unless element.blank? }
