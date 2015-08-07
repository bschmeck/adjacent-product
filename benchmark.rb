require 'benchmark'
require_relative 'window_generator'

N_DIGITS = 1_000_000

n_digits = ARGV[0] || N_DIGITS
n_digits = n_digits.to_i

prng = Random.new
digits = Array.new(n_digits) { prng.rand 10 }

gen = WindowGenerator.new(digits, 4)

Benchmark.bmbm do |x|
  WindowGenerator::STRATEGIES.each do |strategy|
    count = 0
    x.report(strategy) { gen.via(strategy) { count += 1 } }
  end
end
