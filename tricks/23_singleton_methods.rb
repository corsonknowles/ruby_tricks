#!/usr/bin/env ruby
# Trick #23: Singleton Methods (Eigenclass/Metaclass)
# Add methods to individual objects, not the entire class

# Adding a method to a single object
puts "Singleton methods on objects:"
str1 = "hello"
str2 = "world"

# Add method only to str1
def str1.shout
  upcase + "!!!"
end

puts str1.shout
begin
  str2.shout
rescue NoMethodError
  puts "str2 doesn't have shout method"
end

# Using class << object syntax
puts "\nUsing class << syntax:"
obj = Object.new

class << obj
  def greet
    "Hello from singleton!"
  end
  
  def farewell
    "Goodbye!"
  end
end

puts obj.greet
puts obj.farewell

# Singleton methods on classes (class methods)
puts "\nClass methods are singleton methods on the class object:"

class MyClass
  # These are equivalent ways to define class methods
  
  # Way 1: def self.method_name
  def self.method_one
    "Method one"
  end
  
  # Way 2: class << self
  class << self
    def method_two
      "Method two"
    end
  end
end

puts MyClass.method_one
puts MyClass.method_two

# Practical: Configuration objects
puts "\nConfiguration object:"
config = Object.new

class << config
  attr_accessor :host, :port
  
  def url
    "http://#{@host}:#{@port}"
  end
end

config.host = "localhost"
config.port = 3000
puts config.url

# Adding methods dynamically
puts "\nDynamic singleton methods:"
calculator = Object.new

[:add, :subtract, :multiply].each do |operation|
  calculator.define_singleton_method(operation) do |a, b|
    case operation
    when :add then a + b
    when :subtract then a - b
    when :multiply then a * b
    end
  end
end

puts "5 + 3 = #{calculator.add(5, 3)}"
puts "5 - 3 = #{calculator.subtract(5, 3)}"
puts "5 * 3 = #{calculator.multiply(5, 3)}"

# Checking for singleton methods
puts "\nChecking singleton methods:"
obj = "test"
def obj.custom_method; end

puts "Singleton methods: #{obj.singleton_methods.inspect}"
puts "Regular String methods: #{"".methods.count} methods"

# Module inclusion at object level
puts "\nExtending a single object:"
module Greeter
  def greet(name)
    "Hello, #{name}!"
  end
end

obj1 = Object.new
obj2 = Object.new

obj1.extend(Greeter)
puts obj1.greet("Alice")

begin
  obj2.greet("Bob")
rescue NoMethodError
  puts "obj2 doesn't have Greeter methods"
end

# Practical: Mock objects for testing
puts "\nMock object:"
mock_db = Object.new

# Initialize the data array first
mock_db.instance_eval { @data = [] }

# Then add singleton methods
class << mock_db
  def insert(item)
    @data << item
    true
  end
  
  def all
    @data
  end
  
  def count
    @data.length
  end
end

mock_db.insert("item1")
mock_db.insert("item2")
puts "Count: #{mock_db.count}"
puts "All: #{mock_db.all.inspect}"

# Singleton class inspection
puts "\nSingleton class:"
obj = Object.new
puts "Object class: #{obj.class}"
puts "Singleton class: #{obj.singleton_class}"

# Adding methods via singleton_class
obj.singleton_class.class_eval do
  def custom
    "Custom method"
  end
end

puts obj.custom

# Real-world: Decorating objects
puts "\nDecorating objects:"
class User
  attr_accessor :name, :email
  
  def initialize(name, email)
    @name = name
    @email = email
  end
end

admin = User.new("Admin", "admin@example.com")
guest = User.new("Guest", "guest@example.com")

# Add admin-specific behavior
def admin.can_delete?
  true
end

def admin.role
  "Administrator"
end

puts "Admin can delete: #{admin.can_delete?}"
puts "Admin role: #{admin.role}"

begin
  guest.can_delete?
rescue NoMethodError
  puts "Guest doesn't have admin methods"
end

# Comparing with class methods
puts "\nInstance vs Singleton methods:"
class Example
  def instance_method
    "Available to all instances"
  end
end

ex1 = Example.new
ex2 = Example.new

def ex1.custom_single
  "Only available to ex1"
end

puts ex1.instance_method
puts ex2.instance_method
puts ex1.custom_single

begin
  ex2.custom_single
rescue NoMethodError
  puts "ex2 doesn't have custom_single"
end

# Method lookup chain
puts "\nMethod lookup with singleton:"
class Base
  def greet
    "Base greet"
  end
end

obj = Base.new
def obj.greet
  "Singleton greet"
end

puts obj.greet  # Singleton method takes precedence
