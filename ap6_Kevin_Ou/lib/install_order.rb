# Given an Array of tuples, where tuple[0] represents a package id,
# and tuple[1] represents its dependency, determine the order in which
# the packages should be installed. Only packages that have dependencies
# will be listed, but all packages from 1..max_id exist.

# N.B. this is how `npm` works.

# Import any files you need to
require 'byebug'
require_relative './graph'

def install_order(arr)
  results = []

  maxi = arr.flatten.max
  files = (1..maxi).to_a
  queue = files.select {|fi| arr.none? {|tup| tup[0] == fi }}

  while !queue.empty?
    current = queue.shift
    candidates = []
    arr.each do |tup|
      candidates.push(tup[0]) if tup[1] == current
    end
    
    candidates.each do |num|
      arr.delete([num, current])
    end

    candidates.reject! {|num| arr.any? {|tup| tup[0] == num}}
    queue.concat(candidates)
    results.push(current)
  end

  results

end

# display arr
# display files
# display results
# display candidates
# display current
# display queue
# display tup