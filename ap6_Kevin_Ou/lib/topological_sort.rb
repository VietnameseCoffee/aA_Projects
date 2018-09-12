require_relative 'graph'
require 'byebug'

# Implementing topological sort using both Khan's and Tarian's algorithms

def topological_sort(vertices)
  results = []
  queue = vertices.select {|v| v.in_edges.empty? }

  # debugger
  until queue.empty?
    vert = queue.shift

    has_edge = false
    vert.out_edges.each do |edge|
      has_edge = true
      to_vert = edge.to_vertex
      to_vert.in_edges.delete(edge)
      queue.push(to_vert) if to_vert.in_edges.empty?
    end


    if !results.include?(vert)
      results.push(vert)
    else
      return []
    end
  end
  results 
end
