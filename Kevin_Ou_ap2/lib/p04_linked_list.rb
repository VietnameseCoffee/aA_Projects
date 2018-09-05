class Node
  
  attr_accessor :key, :val, :next, :prev
  
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
    # optional but useful, connects previous node to next node
    # and removes self from list.
    prev = self.prev
    after = self.next
    
    prev.next = after
    after.prev = prev
    self.prev = nil
    self.next = nil
  end
end

class LinkedList
  include Enumerable
  def initialize
    @head = Node.new("head", "head")
    @tail = Node.new("tail", "tail")
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |node, j| return node if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    self.each {|node| return node.val if key == node.key}
    nil
  end

  def include?(key)
    self.each {|node| return true if node.key == key }
    false
  end

  def append(key, val)
    before = @tail.prev
    node = Node.new(key, val)

    @tail.prev = node
    before.next = node
    node.prev = before
    node.next = @tail
    
  end

  def update(key, val)

    self.each do |node|
      if node.key == key
        node.val = val
        return true
      end
    end
    nil
  end
  
  def remove(key)

    self.each do |node|
      if node.key == key
        node.remove
        return true
      end
    end
    nil

  end

  def each(&prc)
    # extend Enumerable
    current_node = @head.next

    while current_node != @tail
      prc.call(current_node)
      current_node = current_node.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, node| acc << "[#{node.key}, #{node.val}]" }.join(", ")
  # end
end
