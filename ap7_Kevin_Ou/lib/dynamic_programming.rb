require 'byebug'

class DynamicProgramming


  def initialize
  end
  
  def blair_nums(n)
    @cache ||= {1 => 1, 2=> 2}
    return cache[n] if cache[n]
    cache[n] = blair_nums(n - 1) + blair_nums(n - 2) + ((n - 1) * 2) - 1
    cache[n]

  end

  def frog_hops_bottom_up(n)
    frog_cache_builder(n)
    return cache[n] if cache[n]
  end
  
  def frog_cache_builder(n)
    @cache ||= {
      1 => [[1]],
      2 => [[1,1], [2]],
      3 => [[1,1,1], [1,2], [2,1], [3]]
    }
    (4..n).each do |int|
      # debugger
      ye = cache[int - 3].map { |el| el + [3]}
      yo = cache[int - 2].map { |el| el + [2]}
      bro = cache[int - 1].map { |el| el + [1]}
      cache[int] = ye + yo + bro
    end
    cache[n]
  end
  
  def frog_hops_top_down(n)
    
    ans = frog_hops_top_down_helper(n)
  end
  
  def frog_hops_top_down_helper(n)
    @cache ||= {
      1 => [[1]],
      2 => [[1,1], [2]],
      3 => [[1,1,1], [1,2], [2,1], [3]]
    }
    # debugger
    return @cache[n] if @cache[n]
    ans = []
    ye =  frog_hops_top_down_helper(n - 3).map { |el| el + [3]}
    yo =  frog_hops_top_down_helper(n - 2).map { |el| el + [2]}
    bro =  frog_hops_top_down_helper(n - 1).map { |el| el + [1]}
    cache[n] = ye + yo + bro
    
  end

  def super_frog_hops(n, k)
    return [[]] if n == 0
    return [[1]] if n == 1

    results = []

    (1..k).each do |i|
      break if i > n

      last = i == n ? [n] : super_frog_hops(i, k)[-1]
      next_jump = super_frog_hops(n-i, k)

      last.each do |el1|
        next_jump.each do |el2|
          results.push([el1] + el2)
        end
      end
    end

  	results
  end

  def knapsack(weights, values, capacity)
    # @cache ||= 
    # debugger if capacity == 165
    knapsack_table(weights, values, capacity)
    # debugger
    return @cache.last.max
  end

  # Helper method for bottom-up implementation
  def knapsack_table(weights, values, capacity)
    return @cache = [Array.new(weights.length,0)] if capacity.zero?

    knapsack_table(weights, values, capacity -1) if capacity > 0

    cache.push(Array.new(weights.length,0))

    # if capacity == 25
    # debugger
    # end
    weights.each_index do |i|
      if i == 0
        if weights[i] <= capacity
          cache.last[i] = values[i]
        end
      else
        dif = capacity - weights[i] 
        if dif < 0
          cache.last[i] = cache.last.max
        else
          new_sum = values[i] + cache[dif][i - 1]
          cache.last[i] = [new_sum, cache.last.max].max
        end
      end
    end
  end

  def maze_solver(maze, start_pos, end_pos)
  end

  attr_reader :cache
end


# display capacity
# display cache
# display cache.last
# display i