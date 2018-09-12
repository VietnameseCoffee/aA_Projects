require_relative './binary_search_tree'

def kth_largest(tree_node, k)
  # use in order traversal then key into kth element of arr
  hash = { ct: 0 }

  max_traversal(tree_node, k, hash)
  
  hash[:kth]
end

def max_traversal(tree_node, k, hash)
  return if hash[:kth]

  max_traversal(tree_node.right, k, hash) if tree_node.right
  hash[:ct] += 1
  if hash[:ct] == k
    hash[:kth] = tree_node
    hash[:ct] += 1
    return
  end
  max_traversal(tree_node.left, k, hash) if tree_node.left

end
