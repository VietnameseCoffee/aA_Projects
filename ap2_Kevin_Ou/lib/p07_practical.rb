require_relative 'p05_hash_map'

def can_string_be_palindrome?(string) 
  counter = Hash.new { |h, k| h[k] = 0 }

  string.each_char do |ch|
    counter[ch] += 1
  end

  no_odd = true
  counter.each do |k, v|
    if v.odd? && no_odd
      no_odd = false
    elsif !no_odd
      return false
    end
  end
  true
end
