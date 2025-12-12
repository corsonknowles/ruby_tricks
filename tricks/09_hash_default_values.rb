#!/usr/bin/env ruby
# Trick #9: Hash Default Values
# Set default values for missing hash keys to avoid nil checks

# Default value approach
puts "Hash with default value:"
hash = Hash.new(0)
hash[:a] = 5
puts "Existing key :a = #{hash[:a]}"
puts "Missing key :b = #{hash[:b]}"

# Counting example
puts "\nCounting words:"
words = %w[apple banana apple cherry banana apple]
count = Hash.new(0)
words.each { |word| count[word] += 1 }
puts count.inspect

# Default block (more flexible)
puts "\nHash with default block:"
hash = Hash.new { |h, k| h[k] = [] }
hash[:colors] << "red"
hash[:colors] << "blue"
hash[:numbers] << 1
hash[:numbers] << 2
puts hash.inspect

# Grouping example
puts "\nGrouping by length:"
words = %w[a bb ccc dd eee f]
grouped = Hash.new { |h, k| h[k] = [] }
words.each { |word| grouped[word.length] << word }
puts grouped.inspect

# Default with fetch
puts "\nUsing fetch with default:"
config = {port: 3000}
puts "Port: #{config.fetch(:port, 8080)}"
puts "Host: #{config.fetch(:host, 'localhost')}"

# fetch with block
puts "\nfetch with block:"
cache = {}
value = cache.fetch(:expensive_calc) do
  puts "  Computing expensive calculation..."
  sleep 0.1
  42
end
puts "Value: #{value}"

# Second call returns cached value
value2 = cache.fetch(:expensive_calc) do
  puts "  This won't be called"
  99
end
puts "Value2: #{value2}"

# Warning: be careful with mutable defaults
puts "\nWarning - shared mutable default:"
bad_hash = Hash.new([])
bad_hash[:a] << 1
bad_hash[:b] << 2
puts "bad_hash[:a] = #{bad_hash[:a].inspect}"
puts "bad_hash[:b] = #{bad_hash[:b].inspect}"
puts "They share the same array!"

puts "\nCorrect way with block:"
good_hash = Hash.new { |h, k| h[k] = [] }
good_hash[:a] << 1
good_hash[:b] << 2
puts "good_hash[:a] = #{good_hash[:a].inspect}"
puts "good_hash[:b] = #{good_hash[:b].inspect}"
