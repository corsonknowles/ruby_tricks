#!/usr/bin/env ruby
# Trick #16: Inline Rescue
# Handle exceptions inline without begin/end blocks

# Basic inline rescue
puts "Inline rescue:"
result = Integer("not a number") rescue 0
puts "Result: #{result}"

# Providing default values
puts "\nDefault values on error:"
x = Integer("42") rescue 0
y = Integer("abc") rescue 0
puts "x = #{x}, y = #{y}"

# With method calls
def risky_division(a, b)
  a / b rescue "Cannot divide"
end

puts "\nRisky division:"
puts "10 / 2 = #{risky_division(10, 2)}"
puts "10 / 0 = #{risky_division(10, 0)}"

# File operations
puts "\nFile operations:"
content = File.read("nonexistent.txt") rescue "File not found"
puts content

# Array access
puts "\nSafe array access:"
arr = [1, 2, 3]
value = arr.fetch(10) rescue "Not found"
puts "Value at index 10: #{value}"

# JSON parsing
require 'json'

puts "\nJSON parsing:"
json1 = '{"name": "Alice"}'
json2 = 'invalid json'

data1 = JSON.parse(json1) rescue {}
data2 = JSON.parse(json2) rescue {}
puts "data1: #{data1.inspect}"
puts "data2: #{data2.inspect}"

# Hash access
puts "\nHash access:"
config = {port: 3000}
host = config.fetch(:host) rescue "localhost"
port = config.fetch(:port) rescue 8080
puts "Host: #{host}, Port: #{port}"

# Multiple operations
puts "\nChaining with rescue:"
result = begin
  value = Integer("abc")
  value * 2
rescue
  "Error occurred"
end
puts result

# Careful: catches all StandardError
puts "\nWarning - catches StandardError and subclasses:"
value = begin
  raise ArgumentError, "Specific error"
rescue
  "Caught!"
end
puts value

# Better: rescue specific exceptions
puts "\nBetter: specific exceptions:"
def parse_number(str)
  Integer(str)
rescue ArgumentError, TypeError
  puts "  Caught ArgumentError or TypeError"
  0
end

puts parse_number("not a number")
puts parse_number(nil)

# Rescue with variable
puts "\nRescue with error variable:"
begin
  1 / 0
rescue ZeroDivisionError => e
  puts "Error: #{e.message}"
end

# Not recommended for control flow
# This is generally considered bad practice
def find_user(id)
  # Bad: using exceptions for control flow
  fetch_from_db(id)
rescue NotFoundError
  nil
end

# Better alternative: return nil explicitly
def find_user_better(id)
  result = fetch_from_db_safe(id)
  result[:found] ? result[:user] : nil
end

# When inline rescue is good:
puts "\nGood use cases:"

# 1. Providing defaults
max_connections = ENV['MAX_CONN'].to_i rescue 100
puts "Max connections: #{max_connections}"

# 2. Optional functionality
begin
  require 'colorize'
rescue LoadError
  # Colorize not available
end
text = "Hello"
puts defined?(Colorize) ? "Colorize available" : "Colorize not available"

# 3. Quick scripts and one-liners
urls = ["http://example.com", "invalid url"]
urls.each do |url|
  require 'uri'
  uri = URI.parse(url) rescue (puts "Invalid: #{url}"; next)
  puts "Valid: #{uri.host}"
end
