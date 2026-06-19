#!/usr/bin/env ruby
# Trick #12: Splat Operator (*)
# Handle variable number of arguments and array expansion

# Variable arguments
def sum(*numbers)
  numbers.reduce(0, :+)
end

puts "Variable arguments:"
puts "sum(1, 2, 3) = #{sum(1, 2, 3)}"
puts "sum(1, 2, 3, 4, 5) = #{sum(1, 2, 3, 4, 5)}"
puts "sum() = #{sum()}"

# Mixed arguments
def greet(greeting, *names)
  names.map { |name| "#{greeting}, #{name}!" }
end

puts "\nMixed arguments:"
puts greet("Hello", "Alice", "Bob", "Charlie").inspect

# Splat in method calls (expanding arrays)
def add(a, b, c)
  a + b + c
end

puts "\nExpanding arrays:"
numbers = [1, 2, 3]
puts "add(*numbers) = #{add(*numbers)}"

# Combining arrays
puts "\nCombining arrays:"
arr1 = [1, 2, 3]
arr2 = [4, 5, 6]
combined = [0, *arr1, *arr2, 7]
puts "Combined: #{combined.inspect}"

# In array literals
puts "\nArray literals:"
first = [1, 2]
second = [3, 4]
result = [*first, *second]
puts result.inspect

# Splat in assignment
puts "\nSplat in assignment:"
a, *rest = [1, 2, 3, 4, 5]
puts "a = #{a}, rest = #{rest.inspect}"

first, *middle, last = [1, 2, 3, 4, 5]
puts "first = #{first}, middle = #{middle.inspect}, last = #{last}"

# Double splat for hashes (**)
def configure(name:, **options)
  puts "Name: #{name}"
  puts "Options: #{options.inspect}"
end

puts "\nDouble splat for hashes:"
configure(name: "app", port: 3000, ssl: true, workers: 4)

# Merging hashes
puts "\nMerging hashes:"
defaults = {host: "localhost", port: 3000}
overrides = {port: 8080, ssl: true}
config = {**defaults, **overrides}
puts config.inspect

# Forwarding all arguments
def outer(*args, **kwargs, &block)
  inner(*args, **kwargs, &block)
end

def inner(a, b, c: "default")
  result = "a=#{a}, b=#{b}, c=#{c}"
  result += ", block: #{yield}" if block_given?
  result
end

puts "\nForwarding all arguments:"
puts outer(1, 2, c: "custom") { "from block" }

# Real-world example: building method chains
class QueryBuilder
  def initialize(*conditions)
    @conditions = conditions
  end
  
  def and(*new_conditions)
    QueryBuilder.new(*@conditions, *new_conditions)
  end
  
  def to_s
    @conditions.join(" AND ")
  end
end

puts "\nQuery builder example:"
query = QueryBuilder.new("age > 18", "active = true")
query = query.and("verified = true", "email IS NOT NULL")
puts query.to_s
