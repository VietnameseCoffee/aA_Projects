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

  end

  def knapsack(weights, values, capacity)

  end

  # Helper method for bottom-up implementation
  def knapsack_table(weights, values, capacity)

  end

  def maze_solver(maze, start_pos, end_pos)
  end

  attr_reader :cache
end
