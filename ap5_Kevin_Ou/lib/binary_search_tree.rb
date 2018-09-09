# There are many ways to implement these methods, feel free to add arguments 
# to methods as you see fit, or to create helper methods.
require_relative './bst_node'
require 'byebug'

class BinarySearchTree
  def initialize
    @root = nil
  end

  def insert(value)
    return @root = BSTNode.new(value) if root.nil?

    _insert(@root, value)    
  end
  
  def _insert(parent, value)

    case value <=> parent.value
    when -1..0
      if parent.left.nil?
        parent.left = BSTNode.new(value, parent)
      else
        _insert(parent.left, value)
      end
      
    when 1
      if parent.right.nil?
        parent.right = BSTNode.new(value, parent)
      else
        _insert(parent.right, value)
      end
    end
    
  end 
  
  def find(value, tree_node = @root)
    return nil if root.value.nil?
    case value <=> tree_node.value
    when -1
      if tree_node.left.nil?
        nil
      else
        find(value, tree_node.left)
      end
      
    when 0
      return tree_node

    when 1
      if tree_node.right.nil?
        nil
      else
        find(value, tree_node.right)
      end
      
    end
      
  end

  def delete(value)
    target = find(value, @root)
    return nil if target.nil?

    kids = target.get_kids

    return @root = nil if target == root && kids.empty?

    case kids.length
    when 0 
      target.remove
    when 1
      target.left ? target.replace(kids.first, true) : target.replace(kids.first, false)
    when 2
      max = maximum(target.left)
      adjust(target, max)
    end

  end

  def adjust(target, max)
    # debugger
    if max.left
      max.replace(max.left, true, "adjust")
    end
      target.value = max.value
  end

  # helper method for #delete:
  def maximum(tree_node = @root)
    return tree_node if tree_node.right.nil?
    maximum(tree_node.right)
  end

  def depth(tree_node = @root)
  end 

  def is_balanced?(tree_node = @root)
  end

  def in_order_traversal(tree_node = @root, arr = [])
    # return if tree_node.left.nil?

    # in_order_traversal(tree_node.left, arr)
    # arr.push(tree_node)

  end


  # private
  # optional helper methods go here:
  attr_reader :root
end
