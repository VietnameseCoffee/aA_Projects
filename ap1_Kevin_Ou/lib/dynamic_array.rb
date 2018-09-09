require_relative "static_array"


class DynamicArray
  attr_reader :length

  def initialize
    @length = 0
    @capacity = 8
    @store = StaticArray.new(8)
  end

  # O(1)
  def [](index)
    raise "index out of bounds" if index >= length
    @store[index]
  end

  # O(1)
  def []=(index, value)
    @store[index] = value
  end
  
  # O(1)
  def pop
    raise "index out of bounds" if length <= 0
    
    @length -= 1
    val = @store[@length]
    @store[@length] = nil
    val
  end
  
  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    resize! if @length == @capacity
    @length += 1
    @store[@length - 1] = val
  end
  
  # O(n): has to shift over all the elements.
  def shift
    raise "index out of bounds" if length <= 0
    shifted = self[0].dup
    @length -= 1
    @length.times do |i|
      @store[i] = @store[i + 1]
    end
    @store[@length] = nil
    shifted
  end
  
  # O(n): has to shift over all the elements.
  def unshift(val)
    resize! if @length == @capacity
    
    @length += 1
    (@length).downto(0) {|i| @store[i + 1]= @store[i]}

    @store[0] = val

  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
    resize! if capacity == index
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    # debugger
    new_store = StaticArray.new(@capacity * 2)

    i = 0
    while i < @length
      new_store[i] = @store[i]

      i += 1
    end
    
    @capacity *= 2
    @store = new_store
  end
end
