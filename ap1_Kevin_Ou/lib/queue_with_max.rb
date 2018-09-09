# Implement a queue with #enqueue and #dequeue, as well as a #max API,
# a method which returns the maximum element still in the queue. This
# is trivial to do by spending O(n) time upon dequeuing.
# Can you do it in O(1) amortized? Maybe use an auxiliary storage structure?

# Use your RingBuffer to achieve optimal shifts! Write any additional
# methods you need.

require_relative 'ring_buffer'

class QueueWithMax
  attr_accessor :store, :length
  attr_reader :set, :dictionary, :max

  def initialize
    @store = RingBuffer.new
    @length = 0
    @max = nil
    
    @dictionary = Hash.new {|h, k| h[k] = 0}
    @set = Set.new
  end

  def enqueue(val)
    @length += 1

    store.push(val)
    add_max(val)
  end
  
  def dequeue
    @length -= 1
    remove(store.shift)
  end
  
  def add_max(val)
    @max ||= val
    if val == @max
      dictionary[val] += 1
    elsif val > @max
      set.delete(@max)
      set.add(val)
    end

    @max = (val > @max) ? val : @max

  end

  def remove(val)
    dictionary[val] -= 1
    set.delete(val) if dictionary[val] == 0

    @max = set.to_a.sort.last if @max == val
  end

  def get_max

    @max
  end

end
