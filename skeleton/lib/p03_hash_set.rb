require "p02_hashing"

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    unless @store[key.hash % num_buckets].include?(key)
      @store[key.hash % num_buckets].push(key) 
      @count += 1
    end
    resize! if count > num_buckets
  end

  def include?(key)
    @store[key.hash % num_buckets].include?(key)
  end

  def remove(key)
    if @store[key.hash % num_buckets].include?(key)
      @store[key.hash % num_buckets].delete(key) 
      @count -= 1
    end
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


h = HashSet.new