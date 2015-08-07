#! /usr/bin/env ruby

require_relative 'window_generator'

N_DIGITS = 1_000

n_digits = ARGV[0] || N_DIGITS
n_digits = n_digits.to_i

prng = Random.new
digits = Array.new(n_digits) { prng.rand 10 }

max_prod = 0


puts digits.inspect.to_s

generator = WindowGenerator.new(digits, 4)

best = generator.windows.max { |a, b| a.reduce(:*) <=> b.reduce(:*) }
puts "best is #{best}"

best = generator.windows.max_by { |a| a.reduce(:*) }
puts "best is #{best}"

generator.windows.each do |window|
  prod = window.reduce(:*)
  if prod > max_prod
    max_prod = prod
    best = window.clone
  end
end
puts "best is #{best}"
