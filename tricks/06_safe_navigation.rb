#!/usr/bin/env ruby
# Trick #6: Safe Navigation Operator (&.)
# Prevents NoMethodError when calling methods on nil

# Without safe navigation - would raise error
puts "Without safe navigation:"
name = nil
# This would raise: name.upcase
# NoMethodError: undefined method `upcase' for nil:NilClass

# With safe navigation
puts "With safe navigation:"
result = name&.upcase
puts "Result: #{result.inspect}"

# Works with chaining
puts "\nChaining with safe navigation:"
user = nil
email = user&.profile&.email&.downcase
puts "Email: #{email.inspect}"

# Real-world example
class User
  attr_accessor :profile
end

class Profile
  attr_accessor :email
end

user = User.new
puts "\nUser without profile:"
puts "Email: #{user&.profile&.email&.upcase.inspect}"

user.profile = Profile.new
user.profile.email = "alice@example.com"
puts "\nUser with profile:"
puts "Email: #{user&.profile&.email&.upcase}"

# Useful with arrays
puts "\nWith arrays:"
empty_array = []
first_upcase = empty_array.first&.upcase
puts "First element upcased: #{first_upcase.inspect}"

full_array = ["hello", "world"]
puts "First element upcased: #{full_array.first&.upcase}"

# Assignment with safe navigation
puts "\nConditional assignment:"
value = user&.profile&.email || "no email"
puts "Value: #{value}"
