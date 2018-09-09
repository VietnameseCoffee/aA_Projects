require_relative './binary_search_tree'

def kth_largest(tree_node, k)
  # use in order traversal then key into kth element of arr
  counter = { count: 0 }

  max_traversal(tree_node, k, counter)
  counter[:k]
end

def max_traversal(tree_node, k, counter)
  return if counter[:k]
  
  max_traversal(tree_node.right, k, counter) if tree_node.right
  counter[:count] += 1
  if counter[:count] == k
    counter[:k] = tree_node
    counter[:count] += 1
  end
  max_traversal(tree_node.left, k, counter) if tree_node.left

end
