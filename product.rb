#! /usr/bin/env ruby

N_DIGITS = 1_000

n_digits = ARGV[0] || N_DIGITS
n_digits = n_digits.to_i

prng = Random.new
digits = Array.new(n_digits) { prng.rand 10 }

max_prod = 0

def windows(arr, window_size)
  return to_enum(__callee__, arr, window_size) unless block_given?
  prefix = arr.slice(0, window_size-1)
  arr[(window_size-1)..-1].each do |elt|
    prefix << elt
    yield prefix #.clone
    prefix.delete_at 0
  end
end

puts digits.inspect.to_s

best = windows(digits, 4).max { |a, b| a.reduce(:*) <=> b.reduce(:*) }
puts "best is #{best}"

best = windows(digits, 4).max_by { |a| a.reduce(:*) }
puts "best is #{best}"

windows(digits, 4).each do |window|
  prod = window.reduce(:*)
  if prod > max_prod
    max_prod = prod
    best = window.clone
  end
end
puts "best is #{best}"