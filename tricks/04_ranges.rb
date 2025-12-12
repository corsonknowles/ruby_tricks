#!/usr/bin/env ruby
# Trick #4: Ranges and Enumerable
# Ranges are powerful for creating sequences and checking membership

# Inclusive range (includes end)
puts "Inclusive range (1..5):"
p (1..5).to_a

# Exclusive range (excludes end)
puts "\nExclusive range (1...5):"
p (1...5).to_a

# Character ranges
puts "\nCharacter range:"
p ('a'..'e').to_a

# Checking membership
puts "\nMembership check:"
age = 25
puts "Age #{age} is adult: #{(18..65).include?(age)}"

# Using with each
puts "\nIterating with each:"
(1..3).each { |i| puts "  Number: #{i}" }

# Reverse ranges need reverse_each or .to_a.reverse
puts "\nReverse iteration:"
5.downto(1).each { |i| puts "  Countdown: #{i}" }

# Infinite ranges (Ruby 2.6+)
puts "\nFirst 5 from infinite range:"
p (1..).first(5)

# Step through ranges
puts "\nEven numbers 0-10:"
p (0..10).step(2).to_a

# Using ranges in case statements
score = 85
grade = case score
        when 90..100 then 'A'
        when 80..89  then 'B'
        when 70..79  then 'C'
        when 60..69  then 'D'
        else 'F'
        end
puts "\nScore #{score} gets grade: #{grade}"
