#!/usr/bin/env ruby
# Trick #3: String Interpolation
# Use #{} to embed expressions directly in strings

name = "Ruby"
version = 3.2

# Basic interpolation
puts "Basic interpolation:"
puts "Hello, #{name}!"

# Complex expressions
puts "\nComplex expressions:"
puts "Ruby version #{version} is #{version >= 3 ? 'modern' : 'classic'}"

# Method calls
puts "\nMethod calls:"
puts "Uppercase: #{"hello".upcase}"

# Arithmetic
puts "\nArithmetic:"
puts "2 + 2 = #{2 + 2}"

# Multiple interpolations
count = 5
puts "\nMultiple interpolations:"
puts "I have #{count} #{count == 1 ? 'apple' : 'apples'}"

# Interpolation with instance variables
class Person
  def initialize(name, age)
    @name = name
    @age = age
  end
  
  def introduce
    "Hi, I'm #{@name} and I'm #{@age} years old"
  end
end

person = Person.new("Alice", 30)
puts "\nWith instance variables:"
puts person.introduce
