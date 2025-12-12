#!/usr/bin/env ruby
# Trick #24: Parallel Assignment and Splat Tricks
# Advanced uses of multiple assignment and splat operators

puts "Trick #24: Advanced Parallel Assignment and Splat Tricks"
puts ""

# Basic review
puts "Basic parallel assignment:"
a, b, c = 1, 2, 3
puts "a=#{a}, b=#{b}, c=#{c}"

# Swapping
puts "\nSwapping:"
x, y = 10, 20
puts "Before: x=#{x}, y=#{y}"
x, y = y, x
puts "After: x=#{x}, y=#{y}"

# Rotating values
puts "\nRotating values:"
a, b, c = 1, 2, 3
puts "Before: a=#{a}, b=#{b}, c=#{c}"
a, b, c = b, c, a
puts "After: a=#{a}, b=#{b}, c=#{c}"

# Splat for rest of elements
puts "\nSplat for rest:"
first, *rest = [1, 2, 3, 4, 5]
puts "first=#{first}, rest=#{rest.inspect}"

# Splat in the middle
puts "\nSplat in the middle:"
first, *middle, last = [1, 2, 3, 4, 5]
puts "first=#{first}, middle=#{middle.inspect}, last=#{last}"

# Multiple splats not allowed (syntax error)
# first, *mid1, *mid2, last = [1, 2, 3, 4, 5]  # Error!

# Ignoring values
puts "\nIgnoring values:"
_, b, _ = [1, 2, 3]
puts "Only kept middle: #{b}"

# Nested destructuring
puts "\nNested destructuring:"
(a, b), c = [[1, 2], 3]
puts "a=#{a}, b=#{b}, c=#{c}"

# More complex nesting
puts "\nComplex nesting:"
(a, (b, c)), d = [[1, [2, 3]], 4]
puts "a=#{a}, b=#{b}, c=#{c}, d=#{d}"

# With method returns
def stats
  [10, 5, 15]  # min, avg, max
end

puts "\nMethod returns:"
min, avg, max = stats
puts "Min: #{min}, Avg: #{avg}, Max: #{max}"

# Hash destructuring (Ruby 2.7+)
puts "\nHash pattern matching (Ruby 3.0+):"
person = {name: "Alice", age: 30, city: "NYC"}
# In Ruby 3.0+: person => {name:, age:}
# For compatibility, we'll use fetch:
name = person[:name]
age = person[:age]
puts "name=#{name}, age=#{age}"

# Splat in array creation
puts "\nSplat in array creation:"
arr1 = [1, 2]
arr2 = [3, 4]
combined = [0, *arr1, *arr2, 5]
puts combined.inspect

# Splat in method calls
def add_three(a, b, c)
  a + b + c
end

puts "\nSplat in method calls:"
numbers = [10, 20, 30]
puts "Sum: #{add_three(*numbers)}"

# Converting to array
puts "\nConverting to array:"
a, b, c = 1, 2  # c will be nil
puts "a=#{a}, b=#{b}, c=#{c.inspect}"

a, b = [1, 2, 3, 4]  # extra elements ignored
puts "a=#{a}, b=#{b}"

# Parallel assignment with splat
puts "\nParallel with splat:"
a, b, *c = 1, 2
puts "a=#{a}, b=#{b}, c=#{c.inspect}"

a, *b, c = 1
puts "a=#{a}, b=#{b.inspect}, c=#{c.inspect}"

# Double splat for hashes
puts "\nDouble splat for hashes:"
def greet(name:, **options)
  puts "Name: #{name}"
  puts "Options: #{options.inspect}"
end

greet(name: "Alice", age: 30, city: "NYC")

# Merging hashes
puts "\nMerging hashes:"
defaults = {a: 1, b: 2}
overrides = {b: 3, c: 4}
merged = {**defaults, **overrides}
puts merged.inspect

# Block parameter destructuring
puts "\nBlock parameter destructuring:"
pairs = [[1, 2], [3, 4], [5, 6]]
pairs.each do |a, b|
  puts "  #{a} + #{b} = #{a + b}"
end

# With hash pairs
puts "\nHash pairs:"
hash = {a: 1, b: 2, c: 3}
hash.each do |key, value|
  puts "  #{key} => #{value}"
end

# Practical: Parsing data
puts "\nParsing CSV-like data:"
data = "Alice,30,NYC"
name, age, city = data.split(',')
puts "Name: #{name}, Age: #{age}, City: #{city}"

# Multiple lines
puts "\nParsing multiple lines:"
lines = [
  "Bob,25,LA",
  "Charlie,35,Chicago"
]

lines.each do |line|
  name, age, city = line.split(',')
  puts "  #{name} (#{age}) from #{city}"
end

# Extracting from regex
puts "\nExtracting with regex:"
email = "user@example.com"
if email =~ /(\w+)@([\w.]+)/
  username = $1
  domain = $2
  puts "Username: #{username}, Domain: #{domain}"
end

# Using match with destructuring
match = email.match(/(\w+)@([\w.]+)/)
if match
  _, username, domain = match.to_a
  puts "Username: #{username}, Domain: #{domain}"
end

# Splat with ranges
puts "\nSplat with ranges:"
first, *middle, last = (1..10).to_a
puts "first=#{first}, middle has #{middle.length} elements, last=#{last}"

# Function composition trick
puts "\nFunction composition:"
increment = ->(x) { x + 1 }
double = ->(x) { x * 2 }
square = ->(x) { x ** 2 }

# Apply multiple functions
result = [increment, double, square].inject(5) { |val, fn| fn.call(val) }
puts "((5 + 1) * 2) ** 2 = #{result}"

# Practical: Coordinates
puts "\nWorking with coordinates:"
points = [[0, 0], [1, 1], [2, 4], [3, 9]]

points.each do |x, y|
  puts "  Point (#{x}, #{y})"
end

# Calculate distances
puts "\nDistances from origin:"
points.each do |x, y|
  distance = Math.sqrt(x**2 + y**2).round(2)
  puts "  (#{x}, #{y}) -> #{distance}"
end

# Swapping in array
puts "\nSwapping array elements:"
arr = [1, 2, 3, 4, 5]
puts "Before: #{arr.inspect}"
arr[0], arr[4] = arr[4], arr[0]
puts "After swapping first and last: #{arr.inspect}"

# Multiple assignment in conditionals
puts "\nMultiple assignment in conditionals:"
def get_user
  # returns [success, user] or [false, nil]
  [true, {name: "Alice", email: "alice@example.com"}]
end

success, user = get_user
if success
  puts "User: #{user[:name]}"
else
  puts "Failed to get user"
end
