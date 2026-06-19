#!/usr/bin/env ruby
# Trick #21: unless and until
# Negative conditionals that read more naturally in certain contexts

# unless (opposite of if)
puts "unless (negative conditional):"
age = 15

unless age >= 18
  puts "  Not old enough to vote"
end

# Same as: if age < 18
if age < 18
  puts "  Same condition with if"
end

# unless-else (generally avoid this)
score = 75
unless score >= 90
  puts "\nNot an A grade"
else
  puts "\nA grade!"
end

# Statement modifier form (postfix)
puts "\nStatement modifier:"
name = nil
puts "Name is empty" unless name

# More readable examples
user_active = true
puts "Deactivate user" unless user_active

file_exists = false
puts "File is missing" unless file_exists

# Practical examples
puts "\nPractical examples:"

# 1. Validation
email = "test@example.com"
unless email&.include?("@")
  puts "Invalid email"
end

# 2. Guard clauses
def process_user(user)
  return "No user provided" unless user
  return "User not active" unless user[:active]
  
  "Processing #{user[:name]}"
end

puts process_user(nil)
puts process_user({name: "Alice", active: false})
puts process_user({name: "Bob", active: true})

# until (opposite of while)
puts "\nuntil (loop until condition is true):"
counter = 0
until counter >= 5
  puts "  Counter: #{counter}"
  counter += 1
end

# Same with while
puts "\nSame with while (not):"
counter = 0
while counter < 5
  puts "  Counter: #{counter}"
  counter += 1
end

# until as statement modifier
puts "\nuntil as statement modifier:"
x = 0
begin
  puts "  x = #{x}"
  x += 1
end until x >= 3

# Practical: retry until success
puts "\nRetry pattern:"
attempts = 0
max_attempts = 3
success = false

until success || attempts >= max_attempts
  attempts += 1
  puts "  Attempt #{attempts}"
  # Simulate random success
  success = rand < 0.5
  puts "    Result: #{success ? 'Success!' : 'Failed'}"
end

# Reading from user
puts "\nReading input (simulated):"
# input = nil
# until input == "quit"
#   print "Enter command (quit to exit): "
#   input = gets.chomp
#   puts "You entered: #{input}"
# end
puts "  (Code for reading input until 'quit')"

# unless vs if not
puts "\nReadability comparison:"
puts ""
puts "Good: unless user.nil?"
puts "Bad:  if !user.nil?  (use if user instead)"
puts "Bad:  unless !condition  (double negative)"
puts ""

# When to use unless
puts "Use unless when:"
puts "1. The negative case is more natural"
puts "2. There's no else clause"
puts "3. The condition is simple (not compound)"
puts ""

# When to use until
puts "Use until when:"
puts "1. Waiting for a condition to become true"
puts "2. The loop is about 'not yet done'"
puts "3. It reads more naturally than while not"
puts ""

# Anti-patterns (avoid these)
puts "Anti-patterns to avoid:"
puts ""

# 1. unless with else
puts "1. unless with else (use if instead):"
puts "   unless x > 10"
puts "     # hard to read"
puts "   else"
puts "     # even harder"
puts "   end"
puts ""

# 2. unless with compound conditions
puts "2. unless with compound conditions:"
puts "   unless x > 10 && y < 20  # confusing!"
puts "   Better: if x <= 10 || y >= 20"
puts ""

# 3. Double negatives
puts "3. Double negatives:"
puts "   unless !condition  # very confusing!"
puts "   Better: if condition"
puts ""

# Practical real-world examples
puts "\nReal-world examples:"

# Early return pattern
def save_user(user)
  return false unless user
  return false unless user[:email]
  return false unless user[:name]
  
  puts "  Saving user: #{user[:name]}"
  true
end

save_user(nil)
save_user({name: "Alice"})
save_user({name: "Alice", email: "alice@example.com"})

# Retry until resource available
puts "\nWaiting for resource:"
resource_ready = false
attempts = 0
until resource_ready || attempts > 3
  puts "  Checking resource (attempt #{attempts + 1})"
  resource_ready = rand < 0.6
  attempts += 1
  sleep 0.1 unless resource_ready
end

puts resource_ready ? "  Resource ready!" : "  Timeout"

# Permission checking
def can_edit?(user)
  return false unless user
  return false unless user[:logged_in]
  return false unless user[:role] == "admin"
  true
end

admin = {logged_in: true, role: "admin"}
guest = {logged_in: true, role: "guest"}

puts "\nPermission check:"
puts "Admin can edit: #{can_edit?(admin)}"
puts "Guest can edit: #{can_edit?(guest)}"
