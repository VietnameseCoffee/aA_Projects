require_relative 'heap'

def k_largest_elements(array, k)
  proc = Proc.new {|el1, el2| el1 <=> el2}
  heap = BinaryMinHeap.new(&proc)

  array.each do |num|
    heap.push(num)
    heap.extract if heap.count > k
  end
  heap.store
end
