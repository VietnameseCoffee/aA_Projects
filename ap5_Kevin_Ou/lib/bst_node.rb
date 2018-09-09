require 'byebug'
class BSTNode
  def initialize(value, parent = nil)
    @value = value
    @parent = parent
    @left = nil
    @right = nil
  end

  def remove
    # debugger
    kiddies = get_kids
    if kiddies.empty?
      if self.parent.left == self
        self.parent.left = nil
      else
        self.parent.right = nil
      end
      self.parent = nil
    end
  end

  def replace(child, left, adjust = nil)
    # debugger
    if left
      adjust ? self.parent.right = child : self.parent.left = child

      child.parent = self.parent
      self.left = nil
    else
      self.parent.right = child
      child.parent = self.parent
      self.right = nil
    end
    self.parent = nil

    self
  end

  def get_kids
    [self.left, self.right].reject { |el| el.nil? }
  end

  attr_accessor :left, :right, :parent, :value
end
