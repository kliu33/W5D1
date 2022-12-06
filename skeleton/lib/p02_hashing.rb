class Integer
  # Integer#hash already implemented for you
end


class Array
  def hash
    hash = 123456789
    self.each do |ele|
      hash -= ele.hash
      hash /= (ele.hash % 1337)
    end
    hash 
  end
end

class String
  def hash
    hash = 12346789
    self.each_char.with_index do |char, idx|
      ord = char.ord
      hash /= (ord.hash % 1722) if idx.even?
      hash -= ord.hash
    end
    hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method

  def hash
    hash = 123456789
    self.each do |k, v|
      if k.is_a?(Integer)
        hash -= k.hash
        hash /= (k.hash % 1337)
      else
        ord = k.to_s.ord
        hash /= (ord.hash % 1722)
        hash += ord.hash
      end
      if v.is_a?(Integer)
        hash -= k.hash
        hash /= (k.hash % 1337)
      else
        ord = k.to_s.ord
        hash /= (ord.hash % 1722)
        hash += ord.hash
      end
    end
    hash
    0
  end
end

p [1,2].hash
p [1,2].hash
p "string".hash
p "substring".hash
p [1,2].hash