#!/usr/bin/env ruby
# Trick #20: __FILE__ and __LINE__
# Special constants for introspection and debugging

puts "Trick #20: __FILE__ and __LINE__"
puts ""

# Basic usage
puts "Current file: #{__FILE__}"
puts "Current line: #{__LINE__}"
puts "Previous line was: #{__LINE__ - 1}"

# File path manipulation
puts "\nFile path information:"
puts "Full path: #{File.expand_path(__FILE__)}"
puts "Directory: #{File.dirname(__FILE__)}"
puts "Basename: #{File.basename(__FILE__)}"
puts "Without extension: #{File.basename(__FILE__, '.rb')}"

# __dir__ (shorthand for File.dirname(__FILE__))
puts "\n__dir__ shorthand:"
puts "__dir__ = #{__dir__}"
puts "Same as: #{File.dirname(__FILE__)}"

# Debugging with __FILE__ and __LINE__
def debug_info(message)
  puts "[#{File.basename(__FILE__)}:#{__LINE__}] #{message}"
end

puts "\nDebugging helper:"
debug_info("This is a debug message")

# Better debugging with caller info
def advanced_debug(message, file = __FILE__, line = __LINE__)
  puts "[#{File.basename(file)}:#{line}] #{message}"
end

puts "\nAdvanced debugging:"
advanced_debug("Debug from line below", __FILE__, __LINE__)

# Logging with file and line
class Logger
  def self.log(level, message, file = nil, line = nil)
    location = file && line ? " [#{File.basename(file)}:#{line}]" : ""
    puts "[#{level}]#{location} #{message}"
  end
end

puts "\nLogger with location:"
Logger.log("INFO", "Application started", __FILE__, __LINE__)
Logger.log("DEBUG", "Processing data", __FILE__, __LINE__)
Logger.log("ERROR", "Something went wrong", __FILE__, __LINE__)

# Conditional execution based on __FILE__
puts "\nConditional execution:"
puts "if __FILE__ == $0"
puts "  # This runs only when file is executed directly"
puts "  # Not when it's required by another file"
puts "end"

# Example of main execution guard
if __FILE__ == $0
  puts "\nThis file is being run directly!"
else
  puts "\nThis file is being required"
end

# Using in error messages
def divide(a, b)
  raise ArgumentError, "Denominator cannot be zero (#{__FILE__}:#{__LINE__})" if b.zero?
  a / b
end

puts "\nError with location:"
begin
  divide(10, 0)
rescue ArgumentError => e
  puts "Error: #{e.message}"
end

# Stack trace information
def show_call_stack
  puts "\nCall stack:"
  caller.first(5).each_with_index do |line, i|
    puts "  #{i}: #{line}"
  end
end

def outer_method
  inner_method
end

def inner_method
  show_call_stack
end

outer_method

# __method__ and __callee__
def current_method_name
  puts "Method name: #{__method__}"
end

puts "\n__method__:"
current_method_name

# Practical: Relative file loading
puts "\nRelative path loading:"
puts "config_path = File.join(__dir__, 'config.yml')"
puts "data_path = File.join(__dir__, '..', 'data')"

# Source location
class MyClass
  def my_method
    puts "Defined at: #{method(:my_method).source_location.join(':')}"
  end
end

puts "\nMethod source location:"
MyClass.new.my_method

# __ENCODING__
puts "\nFile encoding:"
puts "__ENCODING__ = #{__ENCODING__}"

# Creating a simple assertion
def assert(condition, message = "Assertion failed", file = __FILE__, line = __LINE__)
  unless condition
    raise "#{message} at #{file}:#{line}"
  end
end

puts "\nSimple assertion:"
begin
  x = 5
  assert(x == 5, "x should be 5", __FILE__, __LINE__)
  puts "Assertion passed!"
  
  assert(x == 10, "x should be 10", __FILE__, __LINE__)
rescue => e
  puts "Assertion failed: #{e.message}"
end

# Practical: Feature flags
def feature_enabled?(feature)
  # In real app, check config or database
  true
end

if feature_enabled?(:new_ui)
  puts "\nNew UI enabled (#{__FILE__}:#{__LINE__})"
else
  puts "\nUsing old UI (#{__FILE__}:#{__LINE__})"
end
