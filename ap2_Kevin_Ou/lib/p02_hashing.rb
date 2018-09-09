require 'byebug'

class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    sum = 0
    self.each_with_index {|el, i| sum += el.hash * i }
    sum
  end
end

class String
  def hash
    sum = 0
    self.each_char.with_index {|el, i| sum += el.ord * (i + 1) }
    sum
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    sum = 0
    i = 5
    self.each do |k, v|
      # debugger
      sum += k.to_s.hash * v.hash
      i += 5
    end
    sum
  end
end
