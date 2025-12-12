#!/usr/bin/env ruby
# Trick #17: Open Classes (Monkey Patching)
# Add or modify methods in existing classes

# Adding methods to built-in classes
class String
  def shout
    "#{upcase}!"
  end
  
  def whisper
    "#{downcase}..."
  end
end

puts "Extended String class:"
text = "hello"
puts text.shout
puts text.whisper

# Adding to Integer
class Integer
  def even_or_odd
    even? ? "even" : "odd"
  end
  
  def factorial
    return 1 if self <= 1
    (1..self).reduce(:*)
  end
end

puts "\nExtended Integer class:"
puts "7 is #{7.even_or_odd}"
puts "5! = #{5.factorial}"

# Adding to Array
class Array
  def second
    self[1]
  end
  
  def third
    self[2]
  end
end

puts "\nExtended Array class:"
arr = [10, 20, 30, 40]
puts "Second element: #{arr.second}"
puts "Third element: #{arr.third}"

# Modifying existing methods (be careful!)
class String
  alias_method :old_reverse, :reverse
  
  def reverse
    puts "  [Reversing string...]"
    old_reverse
  end
end

puts "\nModified reverse method:"
puts "hello".reverse

# Practical example: Adding utility methods
class Numeric
  def percent_of(total)
    return 0 if total.zero?
    (self.to_f / total * 100).round(2)
  end
end

puts "\nPercentage calculations:"
puts "25 is #{25.percent_of(100)}% of 100"
puts "75 is #{75.percent_of(200)}% of 200"

# Adding to Hash
class Hash
  def symbolize_keys
    transform_keys(&:to_sym)
  end
  
  def deep_merge(other)
    merge(other) do |key, old_val, new_val|
      old_val.is_a?(Hash) && new_val.is_a?(Hash) ? old_val.deep_merge(new_val) : new_val
    end
  end
end

puts "\nExtended Hash class:"
hash = {"name" => "Alice", "age" => 30}
puts "Symbolized: #{hash.symbolize_keys.inspect}"

# Refinements (safer alternative to monkey patching)
module StringExtensions
  refine String do
    def pig_latin
      return self if length < 2
      "#{self[1..-1]}#{self[0]}ay"
    end
  end
end

# Without using, pig_latin is not available
begin
  "hello".pig_latin
rescue NoMethodError
  puts "\nWithout refinement: NoMethodError"
end

# With using, it's available in this scope
class RefinementExample
  using StringExtensions
  
  def demo
    puts "With refinement: #{"hello".pig_latin}"
  end
end

RefinementExample.new.demo

# Best practices for monkey patching
puts "\nBest practices:"
puts "1. Use refinements when possible"
puts "2. Namespace your additions"
puts "3. Check if method already exists"
puts "4. Document your changes"

# Safer monkey patching
class Array
  # Only add if it doesn't exist
  unless method_defined?(:sum_safe)
    def sum_safe
      reduce(0, :+)
    end
  end
end

puts "\nSafe addition:"
puts "[1, 2, 3].sum_safe = #{[1, 2, 3].sum_safe}"

# Using prepend for safer overrides
module TimestampedArray
  def <<(item)
    puts "  [#{Time.now}] Adding item: #{item}"
    super
  end
end

class MyArray < Array
  prepend TimestampedArray
end

puts "\nPrepend for safer overrides:"
arr = MyArray.new
arr << 1
arr << 2

# Warning about dangers
puts "\n⚠️  Monkey patching can:"
puts "- Break other code unexpectedly"
puts "- Cause conflicts with gems"
puts "- Make debugging harder"
puts "- Lead to surprising behavior"
puts "\nUse refinements or subclassing when possible!"
