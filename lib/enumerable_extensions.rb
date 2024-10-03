module Enumerable
  def reject_first(obj)
    rejected = false
    self.reject do |item|
      if obj == item && !rejected       
        rejected = true
        true
      else
        false
      end
    end
  end
end
