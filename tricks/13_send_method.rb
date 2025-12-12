#!/usr/bin/env ruby
# Trick #13: Dynamic Method Calling with send
# Call methods dynamically using strings or symbols

class Calculator
  def add(a, b)
    a + b
  end
  
  def subtract(a, b)
    a - b
  end
  
  def multiply(a, b)
    a * b
  end
  
  def divide(a, b)
    b.zero? ? "Cannot divide by zero" : a / b
  end
end

calc = Calculator.new

# Basic send usage
puts "Basic send:"
puts "add(5, 3) = #{calc.send(:add, 5, 3)}"
puts "multiply(4, 7) = #{calc.send(:multiply, 4, 7)}"

# Dynamic method selection
puts "\nDynamic method selection:"
operation = :subtract
puts "Operation #{operation}: #{calc.send(operation, 10, 3)}"

# User input example
puts "\nUser-driven calculation:"
%w[add subtract multiply divide].each do |op|
  result = calc.send(op, 12, 3)
  puts "#{op}(12, 3) = #{result}"
end

# Getting attribute values dynamically
class Person
  attr_accessor :name, :age, :email
  
  def initialize(name, age, email)
    @name = name
    @age = age
    @email = email
  end
end

person = Person.new("Alice", 30, "alice@example.com")

puts "\nDynamic attribute access:"
[:name, :age, :email].each do |attr|
  puts "#{attr}: #{person.send(attr)}"
end

# Setting attributes dynamically
puts "\nDynamic attribute setting:"
person.send(:name=, "Bob")
person.send(:age=, 35)
puts "Updated: #{person.name}, #{person.age}"

# Private methods can be called with send
class Secret
  private
  
  def hidden_method
    "This is private!"
  end
end

secret = Secret.new
puts "\nCalling private methods:"
puts secret.send(:hidden_method)

# public_send (safer - respects visibility)
begin
  puts secret.public_send(:hidden_method)
rescue NoMethodError => e
  puts "Error with public_send: private method 'hidden_method' called"
end

# Metaprogramming example: delegator
class Delegator
  def initialize(target)
    @target = target
  end
  
  def method_missing(method, *args, &block)
    if @target.respond_to?(method)
      puts "Delegating #{method} to target"
      @target.send(method, *args, &block)
    else
      super
    end
  end
  
  def respond_to_missing?(method, include_private = false)
    @target.respond_to?(method, include_private) || super
  end
end

puts "\nDelegator pattern:"
str = "hello world"
delegator = Delegator.new(str)
puts delegator.upcase
puts delegator.reverse

# Practical example: form fields
class Form
  attr_reader :data
  
  def initialize
    @data = {}
  end
  
  def fill(fields)
    fields.each do |field, value|
      setter = "#{field}="
      if respond_to?(setter, true)
        send(setter, value)
      else
        @data[field] = value
      end
    end
  end
  
  def to_s
    @data.inspect
  end
end

puts "\nForm filling example:"
form = Form.new
form.fill(name: "Alice", email: "alice@example.com", age: 30)
puts form.to_s
