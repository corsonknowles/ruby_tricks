#!/usr/bin/env ruby
# Trick #7: tap Method
# Yields self to a block, then returns self - useful for chaining and debugging

# Basic tap usage
puts "Basic tap:"
result = "hello".tap { |s| puts "Processing: #{s}" }.upcase
puts "Result: #{result}"

# Debugging with tap
puts "\nDebugging chain:"
numbers = [1, 2, 3, 4, 5]
result = numbers
  .select { |n| n.even? }
  .tap { |arr| puts "After select: #{arr.inspect}" }
  .map { |n| n * 2 }
  .tap { |arr| puts "After map: #{arr.inspect}" }
puts "Final: #{result.inspect}"

# Building objects
puts "\nBuilding objects with tap:"
class Person
  attr_accessor :name, :age, :email
  
  def to_s
    "#{name}, #{age}, #{email}"
  end
end

person = Person.new.tap do |p|
  p.name = "Alice"
  p.age = 30
  p.email = "alice@example.com"
end
puts person

# Modifying in place
puts "\nModifying arrays:"
array = [1, 2, 3].tap do |a|
  a << 4
  a << 5
end
puts "Array: #{array.inspect}"

# With file operations
puts "\nFile-like operations:"
require 'stringio'
output = StringIO.new.tap do |io|
  io.puts "Line 1"
  io.puts "Line 2"
  io.puts "Line 3"
end
puts "Output:\n#{output.string}"

# Compared to then (yield-self)
puts "\ntap vs then:"
puts "tap returns self:"
p [1, 2, 3].tap { |a| a.sum }  # Returns array

puts "then returns block result:"
p [1, 2, 3].then { |a| a.sum }  # Returns sum
