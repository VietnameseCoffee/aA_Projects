require 'byebug'

class BinaryMinHeap
  attr_reader :store, :prc
  
  def initialize(&prc)
    @prc = prc
    @store = []
    @count = 0
  end
  
  def count
    @count
  end
  
  def extract
    store[0], store[count - 1] = store[count - 1], store[0]
    popped = store.pop
    @count -= 1
    BinaryMinHeap.heapify_down(store, 0)
    popped
  end

  def peek
    @store.first
  end

  def push(val)
    prc = Proc.new { |el1, el2|( el1 <=> el2)  }
    # debugger
    store.push(val)
    @count += 1
    return if count == 1
    BinaryMinHeap.heapify_up(store, store.length - 1)
  end

  public
  def self.child_indices(len, parent_index)
    results = Array.new(2) {|i| parent_index * 2 + (i + 1)}
    results.select { |el| el < len }
    
  end
  
  def self.parent_index(child_index)
    raise "root has no parent" if child_index.zero?
    (child_index - 1) / 2 
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }
    
    min_idx = true
    
    while min_idx
      min_idx = nil
      children = BinaryMinHeap.child_indices(len, parent_idx)
      children.select! {|el| el <= len}
      if !children.empty?
        children.each do |idx|
          if prc.call(array[parent_idx], array[idx]) == 1
            if !min_idx || prc.call(array[min_idx], array[idx]) == 1
              min_idx = idx
            end
          end  
        end
        
        if min_idx
          array[parent_idx], array[min_idx] = array[min_idx], array[parent_idx]
          parent_idx = min_idx
        end
      end
    end
    
    return array
  end
  
  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }
    heap_up = true

    while heap_up
      heap_up = false
      
      parent = BinaryMinHeap.parent_index(child_idx)
      if prc.call(array[parent],array[child_idx]) == 1
        array[parent], array[child_idx] = array[child_idx], array[parent]
        child_idx = parent
        heap_up = true
      end
      break if parent.zero?
    end

    return array
  end
end
