class MaxIntSet
  def initialize(max)
    @max = max
    @store = Array.new(max + 1)
  end

  def insert(num)
    raise "Out of bounds" if is_valid?(num)
    store[num] = num
    true
  end

  def remove(num)
    store[num] = nil
  end

  def include?(num)
    store[num] ? true : false
  end

  private

  attr_reader :store, :max
  
  def is_valid?(num)
    num > max || num < 0
  end
  
  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    if include?(num)
      return false
    end
    self[num].push(num)
    true
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  attr_reader :store

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num/20]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    resize! if num_buckets == @count
    self[num].push(num)
    @count += 1
  end
  
  def remove(num)
    self[num].delete(num)
    @count -= 1
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num / num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_buckets = Array.new(num_buckets * 2) { Array.new }
    @store.flatten.each { |num| new_buckets[num / new_buckets.length].push(num)}
    @store = new_buckets
  end
end
