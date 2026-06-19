#!/usr/bin/env ruby
# Trick #10: Keyword Arguments
# Make method signatures clearer and enable default values

# Basic keyword arguments
def greet(name:, greeting: "Hello")
  "#{greeting}, #{name}!"
end

puts "Basic keyword arguments:"
puts greet(name: "Alice")
puts greet(name: "Bob", greeting: "Hi")

# Required vs optional
def create_user(email:, name: "Anonymous", role: "user")
  {email: email, name: name, role: role}
end

puts "\nRequired vs optional:"
puts create_user(email: "alice@example.com").inspect
puts create_user(email: "bob@example.com", name: "Bob", role: "admin").inspect

# Keyword splat (**)
def log_event(event:, **details)
  puts "Event: #{event}"
  puts "Details: #{details.inspect}"
end

puts "\nKeyword splat:"
log_event(event: "login", user_id: 123, ip: "192.168.1.1", timestamp: Time.now)

# Forwarding arguments
def outer_method(**kwargs)
  inner_method(**kwargs)
end

def inner_method(a:, b:, c: "default")
  "a=#{a}, b=#{b}, c=#{c}"
end

puts "\nForwarding arguments:"
puts outer_method(a: 1, b: 2)
puts outer_method(a: 1, b: 2, c: 3)

# Mixing positional and keyword arguments
def process_data(data, format: :json, pretty: false)
  "Processing #{data} as #{format}#{pretty ? ' (pretty)' : ''}"
end

puts "\nMixing positional and keyword:"
puts process_data("user.txt")
puts process_data("user.txt", format: :xml)
puts process_data("user.txt", format: :json, pretty: true)

# Real-world example: configuration
class Server
  def initialize(host: "localhost", port: 3000, ssl: false, workers: 4)
    @host = host
    @port = port
    @ssl = ssl
    @workers = workers
  end
  
  def info
    "Server at #{@ssl ? 'https' : 'http'}://#{@host}:#{@port} with #{@workers} workers"
  end
end

puts "\nReal-world example:"
puts Server.new.info
puts Server.new(port: 8080, ssl: true).info
puts Server.new(host: "example.com", port: 443, ssl: true, workers: 8).info

# Ruby 3.0+ shorthand
def print_person(name:, age:)
  puts "Name: #{name}, Age: #{age}"
end

puts "\nRuby 3.0+ shorthand:"
name = "Alice"
age = 30
print_person(name: name, age: age)  # Old way
# Ruby 3.0+ introduced shorthand syntax (requires Ruby >= 3.1):
# print_person(name:, age:)  # Shorthand when variable name matches key
