
class MaxIntSet

  attr_reader :store
  def initialize(max)
    @store = Array.new(max, false)
  end

  def insert(num)
    raise "Out of bounds" if num < 0 || num > @store.length
    if @store[num] == false
      @store[num] = true
    end
  end

  def remove(num)
    raise "Out of bounds" if num < 0 || num > @store.length
    if @store[num] == true
      @store[num] = false
    end
  end

  def include?(num)
    @store[num]
  end

  private

  def is_valid?(num)
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    @store[num % @store.length].push(num) if !@store[num % @store.length].include?(num)
  end

  def remove(num)
    @store[num % @store.length].delete(num) if @store[num % @store.length].include?(num)
  end

  def include?(num)
    @store[num % @store.length].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :store, :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    unless @store[num % num_buckets].include?(num)
      @store[num % num_buckets].push(num) 
      @count += 1
    end
    resize! if count > num_buckets
  end

  def remove(num)
    if @store[num % num_buckets].include?(num)
      @store[num % num_buckets].delete(num)
      @count -= 1
    end
  end

  def include?(num)
    @store[num % num_buckets].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    temp = []
    @store.each do |sub|
      sub.each do |ele|
        temp << ele
      end
    end
    @store = Array.new(num_buckets * 2) {Array.new}
    @count = 0
    temp.each do |ele|
      self.insert(ele)
    end
  end
end


# st = ResizingIntSet.new
# st.insert(1)
# st.insert(1)

# st.insert(1)

# p st.store