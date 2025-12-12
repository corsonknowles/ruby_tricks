#!/usr/bin/env ruby
# Trick #5: Multiple Assignment (Parallel Assignment)
# Assign multiple variables at once, including swapping without temp variables

# Basic multiple assignment
puts "Basic multiple assignment:"
a, b, c = 1, 2, 3
puts "a=#{a}, b=#{b}, c=#{c}"

# Swapping variables without temp
puts "\nSwapping without temp variable:"
x, y = 10, 20
puts "Before: x=#{x}, y=#{y}"
x, y = y, x
puts "After: x=#{x}, y=#{y}"

# Array destructuring
puts "\nArray destructuring:"
arr = [1, 2, 3, 4, 5]
first, second, *rest = arr
puts "first=#{first}, second=#{second}, rest=#{rest.inspect}"

# Ignoring values with underscore
puts "\nIgnoring values:"
_, _, third = [1, 2, 3]
puts "third=#{third}"

# Method return values
def get_user_info
  ["John", 30, "Engineer"]
end

puts "\nMultiple return values:"
name, age, job = get_user_info
puts "#{name}, #{age}, #{job}"

# Splat in the middle
puts "\nSplat in the middle:"
first, *middle, last = [1, 2, 3, 4, 5]
puts "first=#{first}, middle=#{middle.inspect}, last=#{last}"

# Hash destructuring (Ruby 3+)
puts "\nHash pattern matching:"
hash = {a: 1, b: 2, c: 3}
hash => {a:, b:}
puts "a=#{a}, b=#{b}"
