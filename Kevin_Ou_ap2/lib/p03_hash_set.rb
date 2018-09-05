require_relative 'p02_hashing'
require 'byebug'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    resize! if num_buckets == count
    self[key.hash].push(key)
    @count += 1
    true
  end
  
  def include?(key)
    self[key.hash].include?(key)
  end
  
  def remove(key)
    self[key.hash].delete(key)
    @count -= 1
    true
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_buckets = Array.new(num_buckets * 2) { Array.new }
    @store.flatten.each { |el| new_buckets[el.hash % new_buckets.length].push(el)}
    @store = new_buckets
  end
end
