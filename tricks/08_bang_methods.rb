#!/usr/bin/env ruby
# Trick #8: Bang (!) Methods
# Methods ending with ! modify the object in-place (destructive)

# String methods
puts "String methods:"
str = "  hello world  "
puts "Original: '#{str}'"

# Non-bang version (returns new object)
result = str.strip
puts "After strip (non-bang): '#{result}'"
puts "Original unchanged: '#{str}'"

# Bang version (modifies in place)
str.strip!
puts "After strip! (bang): '#{str}'"

# More examples
puts "\nMore string examples:"
text = "hello"
puts "Before upcase!: #{text}"
text.upcase!
puts "After upcase!: #{text}"

# Array methods
puts "\nArray methods:"
arr = [3, 1, 4, 1, 5]
puts "Original: #{arr.inspect}"

sorted = arr.sort
puts "After sort: #{sorted.inspect}"
puts "Original unchanged: #{arr.inspect}"

arr.sort!
puts "After sort!: #{arr.inspect}"

# Common bang methods
puts "\nCommon bang methods:"
words = ["apple", "banana", "cherry"]
puts "Original: #{words.inspect}"

words.map! { |w| w.upcase }
puts "After map!: #{words.inspect}"

words.select! { |w| w.length > 5 }
puts "After select!: #{words.inspect}"

words.reject! { |w| w.start_with?('B') }
puts "After reject!: #{words.inspect}"

# Hash methods
puts "\nHash methods:"
hash = {a: 1, b: 2, c: 3}
puts "Original: #{hash.inspect}"

hash.delete_if { |k, v| v.even? }
puts "After delete_if (modifies in place): #{hash.inspect}"

# Be careful with freeze
puts "\nFrozen objects can't use bang methods:"
frozen = "frozen".freeze
begin
  frozen.upcase!
rescue FrozenError => e
  puts "Error: #{e.message}"
end

# Custom bang methods convention
class MyArray
  def initialize(arr)
    @data = arr
  end
  
  def double
    MyArray.new(@data.map { |x| x * 2 })
  end
  
  def double!
    @data.map! { |x| x * 2 }
    self
  end
  
  def inspect
    @data.inspect
  end
end

puts "\nCustom bang method:"
my_arr = MyArray.new([1, 2, 3])
puts "Original: #{my_arr.inspect}"
my_arr.double!
puts "After double!: #{my_arr.inspect}"
