require_relative 'p02_hashing'
require_relative 'p04_linked_list'
require 'byebug'

class HashMap
  include Enumerable
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    # @store[key.hash % num_buckets].include?(key)
    self.each {|k, v| return true if k == key}
    return false
  end

  def set(key, val)
    resize! if @count == num_buckets
    list = @store[key.hash % num_buckets]
    if  include?(key)
      list.update(key, val)
    else 
      list.append(key, val)
      @count += 1
    end
    true
  end

  def get(key)
    @store[key.hash % num_buckets].get(key)
  end

  def delete(key)
    @count -= 1 if @store[key.hash % num_buckets].remove(key)
  end

  def each(&prc)
    @store.each do |bucket|
      bucket.each {|node| prc.call(node.key, node.val)}
    end
  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    new_hash = Array.new(num_buckets * 2) { LinkedList.new }

    self.each do |k, v|
      new_hash[(k.hash) % (num_buckets * 2)].append(k, v)
    end
    @store = new_hash
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
  end
end
