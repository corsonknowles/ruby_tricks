#!/usr/bin/env ruby
# Trick #1: Symbol to Proc
# The & operator converts a symbol to a proc, making map operations more concise

# Long way
numbers = [1, 2, 3, 4, 5]
puts "Long way:"
p numbers.map { |n| n.to_s }

# Short way using Symbol to Proc
puts "\nUsing Symbol to Proc:"
p numbers.map(&:to_s)

# More examples
words = ["hello", "world", "ruby"]
puts "\nUppercase with Symbol to Proc:"
p words.map(&:upcase)

puts "\nString length:"
p words.map(&:length)

# Works with any method that takes no arguments
puts "\nReverse strings:"
p words.map(&:reverse)
