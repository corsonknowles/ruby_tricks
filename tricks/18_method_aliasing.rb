#!/usr/bin/env ruby
# Trick #18: Method Aliasing
# Create alternative names for methods

class Person
  def initialize(name)
    @name = name
  end
  
  def name
    @name
  end
  
  # Alias for name
  alias_method :get_name, :name
  alias full_name name  # Alternative syntax
end

puts "Basic aliasing:"
person = Person.new("Alice")
puts "name: #{person.name}"
puts "get_name: #{person.get_name}"
puts "full_name: #{person.full_name}"

# Aliasing for backwards compatibility
class User
  attr_accessor :email
  
  def initialize(email)
    @email = email
  end
  
  # Old method name for backwards compatibility
  alias_method :email_address, :email
  alias_method :email_address=, :email=
end

puts "\nBackwards compatibility:"
user = User.new("alice@example.com")
puts "email: #{user.email}"
puts "email_address: #{user.email_address}"
user.email_address = "bob@example.com"
puts "Updated via alias: #{user.email}"

# Aliasing before overriding (decorator pattern)
class Calculator
  def add(a, b)
    a + b
  end
  
  # Save original method
  alias_method :simple_add, :add
  
  # Override with logging
  def add(a, b)
    puts "  Adding #{a} and #{b}"
    result = simple_add(a, b)
    puts "  Result: #{result}"
    result
  end
end

puts "\nDecorator pattern with aliasing:"
calc = Calculator.new
calc.add(5, 3)

# Chaining method modifications
class String
  # First modification
  alias_method :original_upcase, :upcase
  
  def upcase
    puts "  [Converting to uppercase]"
    original_upcase
  end
  
  # Second modification
  alias_method :logged_upcase, :upcase
  
  def upcase
    result = logged_upcase
    puts "  [Finished: #{result}]"
    result
  end
end

puts "\nChained modifications:"
"hello".upcase

# Practical: Adding features while preserving original
class Array
  alias_method :original_push, :push
  
  def push(*items)
    puts "  Adding #{items.length} item(s)"
    original_push(*items)
  end
end

puts "\nEnhanced push:"
arr = []
arr.push(1, 2, 3)
puts "Array: #{arr.inspect}"

# Using alias for shorter names
class Configuration
  def initialize
    @settings = {}
  end
  
  def get_setting(key)
    @settings[key]
  end
  
  def set_setting(key, value)
    @settings[key] = value
  end
  
  # Shorter aliases
  alias_method :[], :get_setting
  alias_method :[]=, :set_setting
end

puts "\nShorter method names:"
config = Configuration.new
config[:host] = "localhost"
config[:port] = 3000
puts "Host: #{config[:host]}"
puts "Port: #{config[:port]}"

# Difference between alias and alias_method
class AliasExample
  def greeting
    "Hello"
  end
  
  # alias is a keyword (doesn't need comma, uses symbols/names)
  alias simple_greeting greeting
  
  # alias_method is a method (needs comma, uses symbols/strings)
  alias_method :formal_greeting, :greeting
end

puts "\nalias vs alias_method:"
example = AliasExample.new
puts example.simple_greeting
puts example.formal_greeting

# Note: alias is lexically scoped, alias_method is not
module Greeting
  def hello
    "Hello"
  end
  
  # This works
  alias hi hello
end

class Greeter
  include Greeting
end

puts "\nModule aliasing:"
greeter = Greeter.new
puts greeter.hello
puts greeter.hi

# Real-world: ActiveRecord-style aliasing
class Model
  def save
    puts "  Saving to database..."
    true
  end
  
  def save!
    save || raise("Failed to save!")
  end
  
  alias_method :persist, :save
  alias_method :persist!, :save!
end

puts "\nActiveRecord-style:"
model = Model.new
model.persist
