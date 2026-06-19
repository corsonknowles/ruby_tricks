#!/usr/bin/env ruby
# Trick #11: Array Coercion with Array()
# Safely convert values to arrays, handling nil and single values

# Array() kernel method
puts "Array() method:"
puts "Array(nil): #{Array(nil).inspect}"
puts "Array(42): #{Array(42).inspect}"
puts "Array([1, 2]): #{Array([1, 2]).inspect}"
puts "Array('hello'): #{Array('hello').inspect}"

# Useful for defensive programming
def process(items)
  Array(items).each do |item|
    puts "Processing: #{item}"
  end
end

puts "\nHandling various inputs:"
process(nil)
process(42)
process([1, 2, 3])

# Compared to to_a
puts "\nArray() vs to_a:"
puts "nil.to_a: #{nil.to_a.inspect}"
# 42.to_a would raise NoMethodError
puts "Array(42): #{Array(42).inspect}"

# Range example
puts "\nWith ranges:"
puts "Array(1..5): #{Array(1..5).inspect}"
puts "(1..5).to_a: #{(1..5).to_a.inspect}"

# Hash example
puts "\nWith hashes:"
hash = {a: 1, b: 2}
puts "Array(hash): #{Array(hash).inspect}"
puts "hash.to_a: #{hash.to_a.inspect}"

# Splat operator for similar effect
puts "\nSplat operator:"
def with_splat(*items)
  puts "Received: #{items.inspect}"
end

with_splat(1)
with_splat(1, 2, 3)
with_splat([1, 2, 3])  # Note: wraps array in another array

# Building arrays conditionally
puts "\nBuilding arrays conditionally:"
def build_list(include_zero: false)
  [].tap do |arr|
    arr << 0 if include_zero
    arr << 1
    arr << 2
    arr << 3
  end
end

puts "Without zero: #{build_list.inspect}"
puts "With zero: #{build_list(include_zero: true).inspect}"

# Compact trick
puts "\nCompact to remove nils:"
arr = [1, nil, 2, nil, 3]
puts "Original: #{arr.inspect}"
puts "Compacted: #{arr.compact.inspect}"

# flatten for nested arrays
puts "\nFlatten nested arrays:"
nested = [1, [2, 3], [4, [5, 6]]]
puts "Nested: #{nested.inspect}"
puts "Flatten: #{nested.flatten.inspect}"
puts "Flatten(1): #{nested.flatten(1).inspect}"
