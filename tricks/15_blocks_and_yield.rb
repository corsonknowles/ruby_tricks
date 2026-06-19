#!/usr/bin/env ruby
# Trick #15: Blocks and Yield
# Pass behavior to methods using blocks

# Basic yield
def greet
  puts "Before block"
  yield
  puts "After block"
end

puts "Basic yield:"
greet { puts "  Hello from block!" }

# Yield with arguments
def repeat(times)
  times.times do |i|
    yield(i)
  end
end

puts "\nYield with arguments:"
repeat(3) { |i| puts "  Iteration #{i}" }

# Check if block given
def optional_block
  if block_given?
    result = yield
    puts "Block returned: #{result}"
  else
    puts "No block provided"
  end
end

puts "\nOptional block:"
optional_block { "Hello!" }
optional_block

# Multiple yields
def sandwich
  puts "Top bread"
  yield
  puts "Bottom bread"
end

puts "\nMultiple yields:"
sandwich { puts "  🧀 Cheese" }

# Blocks with multiple arguments
def coordinates
  yield(10, 20)
  yield(30, 40)
end

puts "\nMultiple arguments:"
coordinates { |x, y| puts "  Point: (#{x}, #{y})" }

# Capturing blocks as procs
def capture_block(&block)
  puts "Block class: #{block.class}"
  puts "Calling block:"
  block.call("Alice")
  
  # Can store and call later
  @stored_block = block
end

puts "\nCapturing blocks:"
capture_block { |name| puts "  Hello, #{name}!" }

# Practical example: timing
def time_execution
  start = Time.now
  result = yield
  elapsed = Time.now - start
  puts "Execution time: #{elapsed.round(4)}s"
  result
end

puts "\nTiming example:"
result = time_execution do
  sleep 0.1
  (1..1000).reduce(:+)
end
puts "Result: #{result}"

# Transaction pattern
class Database
  def transaction
    begin
      puts "Beginning transaction"
      result = yield
      puts "Committing transaction"
      result
    rescue => e
      puts "Rolling back transaction: #{e.message}"
      nil
    end
  end
end

puts "\nTransaction pattern:"
db = Database.new
db.transaction do
  puts "  Doing database work..."
  "Success!"
end

# Building custom iterators
class Range
  def my_each
    current = self.first
    while current <= self.last
      yield(current)
      current += 1
    end
  end
end

puts "\nCustom iterator:"
(1..5).my_each { |n| puts "  Number: #{n}" }

# Block local variables
puts "\nBlock local variables:"
x = "outer"
[1, 2, 3].each do |x|
  puts "  Inside block: x = #{x}"
end
puts "Outside block: x = #{x}"

# Using blocks for configuration
class Server
  attr_accessor :host, :port, :ssl
  
  def initialize
    @host = "localhost"
    @port = 3000
    @ssl = false
    yield(self) if block_given?
  end
  
  def to_s
    "#{@ssl ? 'https' : 'http'}://#{@host}:#{@port}"
  end
end

puts "\nConfiguration with blocks:"
server = Server.new do |s|
  s.host = "example.com"
  s.port = 8080
  s.ssl = true
end
puts server
