require_relative "static_array"
require 'byebug'

class RingBuffer
  attr_reader :length

  def initialize
    @store = StaticArray.new(8)
    @capacity = 8
    @start_idx = 0
    @length = 0
  end

  # O(1)
  def [](index)
    raise "index out of bounds" if index >= length
    @store[index + start_idx]
  end

  # O(1)
  def []=(index, val)
    raise "index out of bounds" if index >= length
    @store[index + start_idx] = val
  end

  # O(1)
  def pop
    raise "index out of bounds" if length <= 0

    popped = self[(@length -1)]
    self[(@length -1)] = nil
    @length -= 1
    popped
  end
  
  # O(1) ammortized
  def push(val)
    resize! if @length == @capacity
    @length += 1
    self[(@length -1 )] = val
  end

  # O(1)
  def shift
    raise "index out of bounds" if length <= 0
    shifted = self[0]
    self[0] = nil
    @length -= 1    
    @start_idx += 1
    shifted
  end
  
  # O(1) ammortized
  def unshift(val)
    resize! if @length == @capacity
    
    # debugger

    @length += 1
    @start_idx -= 1
    self[0] = val
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
    (start_idx + index) % @capacity
  end

  def resize!
    new_store = StaticArray.new(@capacity * 2)

    i = 0
    while i < @length
      new_store[i] = self[i]

      i += 1
    end
    @start_idx = 0
    @capacity *= 2
    @store = new_store
  end
end
