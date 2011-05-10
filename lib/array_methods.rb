class Array

  def in_groups_of_two
    # turns ["A", "B", "C"] into [["A", "B"], ["B", "C"]]
  
    self.zip(self[1..self.length]).map {|arr| arr unless arr.last.nil? }.compact
  end

end