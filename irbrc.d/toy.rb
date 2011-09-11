class Array
  def self.toy(n=6, &blk)
    blk ||= lambda{|i| i+1 }
    Array.new(n, &blk)
  end
end

class Hash
  def self.toy(n=6)
    keys = Array.toy(n){|c| ('a'.ord + c).chr.to_sym }
    vals = Array.toy(n)
    self[ keys.zip(vals) ]
  end
end
