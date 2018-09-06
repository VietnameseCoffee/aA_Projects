require_relative "heap"
require 'byebug'

class Array
  def heap_sort!
    prc = Proc.new { |el1, el2| (el1 <=> el2) * -1 }
    self.each_index do |i|
      next if i == 0
      BinaryMinHeap.heapify_up(self, i, &prc)
    end

    (self.length - 1).downto(0) do |i|
      # break if i == 1
      self[0], self[i] = self[i], self[0]
      BinaryMinHeap.heapify_down(self, 0, (i), &prc)
    end

  end
end
