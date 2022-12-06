class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end

class LinkedList
  
  include Enumerable

  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    queue = [@head.next]
    idx = 0
    until queue.empty?
      check = queue.shift
      return idx if idx == i
      if check.next != @tail
        queue << check.next 
        idx += 1
      end
    end
  end

  def first
    @head.next
  end

  def last
    che = @head.next
    while true
      return che if che.next == @tail
      che = che.next
    end
  end

  def empty?
    @head.next == @tail && @tail.prev == @head && @head.prev == nil && @tail.next == nil
  end

  def get(key)
    queue = [@head.next]
    until queue.empty?
      check = queue.shift
      return check.val if check.key == key
      queue << check.next if check.next != @tail
    end
  end

  def include?(key)
    queue = [@head.next]
    until queue.empty?
      check = queue.shift
      return true if check.key == key
      queue << check.next if check.next != @tail
    end
    false
  end

  def append(key, val)
    add = Node.new(key, val)
    if empty?
      @head.next = add
    else
      @tail.prev.next = add
    end
    add.prev = @tail.prev
    add.next = @tail
    @tail.prev = add
  end

  def update(key, val)
    queue = [@head.next]
    until queue.empty?
      check = queue.shift
      check.val = val if check.key == key
      queue << check.next if check.next != @tail
    end
  end

  def remove(key)
    queue = [@head.next]
    until queue.empty?
      check = queue.shift
      if check.key == key
        check.next.prev = check.prev
        check.prev.next = check.next
        return true
      end
      queue << check.next if check.next != @tail
    end
  end

  def each
    queue = [@head.next]
    out = []
    until queue.empty?
      check = queue.shift
      out << check.val if check.val != nil
      queue << check.next if check.next != @tail
    end
    out
  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  # end
end

l = LinkedList.new

l.empty?