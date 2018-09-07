require 'byebug'
class QuickSort

  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if array.empty?

    pivot = array[0]
    left = []
    right = []
    
    i = 0
    while i < array.length
      if array[i] <= pivot
        left.push(array[i]) 
      else
        right.push(array[i])
      end
      i += 1
    end

    return self.sort1(left) + [pivot] + self.sort1(right)
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    return if length < 1
    prc ||= Proc.new { |i, j| i <=> j }
    pivot_index = self.partition(array, start, length, &prc)
    left = self.sort2!(array, start, (pivot_index - start), &prc)
    right = self.sort2!(array, (pivot_index + 1), (length - pivot_index), &prc)
  end
  
  def self.partition(array, start, length, &prc)
  
    prc ||= Proc.new { |i, j| i <=> j }
    
    pivot = start
    i = start + 1
    while i < start + length
      case prc.call(array[start], array[i])
      when 1
        array[pivot + 1], array[i] = array[i], array[pivot + 1]
        pivot += 1
      when 0
        pivot += 1
      else
        "LMFAO" 
      end
      
      i += 1
    end
    
    array[start], array[pivot] = array[pivot], array[start]
    pivot

  end
end

# display array
# display pivot_index
# display start
# display length