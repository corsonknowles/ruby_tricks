#!/usr/bin/env ruby
# Trick #22: Advanced Iteration Methods
# each_with_index, each_slice, each_cons, and more

# each_with_index - iterate with index
puts "each_with_index:"
%w[apple banana cherry].each_with_index do |fruit, index|
  puts "  #{index}: #{fruit}"
end

# each_with_object - build an object while iterating
puts "\neach_with_object (building a hash):"
counts = %w[a b c a b a].each_with_object(Hash.new(0)) do |letter, hash|
  hash[letter] += 1
end
puts counts.inspect

# map.with_index
puts "\nmap.with_index:"
numbered = %w[apple banana cherry].map.with_index do |fruit, i|
  "#{i + 1}. #{fruit}"
end
puts numbered.inspect

# each_slice - iterate in chunks
puts "\neach_slice (chunks of 2):"
[1, 2, 3, 4, 5, 6].each_slice(2) do |pair|
  puts "  Pair: #{pair.inspect}"
end

# each_cons - consecutive elements (sliding window)
puts "\neach_cons (consecutive pairs):"
[1, 2, 3, 4, 5].each_cons(2) do |pair|
  puts "  #{pair[0]} -> #{pair[1]}"
end

# with 3 consecutive elements
puts "\neach_cons (3 consecutive):"
[1, 2, 3, 4, 5].each_cons(3) do |triple|
  puts "  #{triple.inspect}"
end

# cycle - repeat iteration
puts "\ncycle (repeat 3 times):"
%w[red green blue].cycle(3) do |color|
  print "#{color} "
end
puts

# reverse_each
puts "\nreverse_each:"
[1, 2, 3, 4, 5].reverse_each do |n|
  print "#{n} "
end
puts

# each_key, each_value for hashes
puts "\nHash iteration:"
hash = {a: 1, b: 2, c: 3}

print "Keys: "
hash.each_key { |k| print "#{k} " }
puts

print "Values: "
hash.each_value { |v| print "#{v} " }
puts

# Practical: batch processing
puts "\nBatch processing (each_slice):"
items = (1..10).to_a
puts "Processing 10 items in batches of 3:"
items.each_slice(3).with_index do |batch, batch_num|
  puts "  Batch #{batch_num + 1}: #{batch.inspect}"
end

# Practical: moving average (each_cons)
puts "\nMoving average with each_cons:"
data = [10, 20, 15, 25, 30]
puts "Data: #{data.inspect}"
averages = data.each_cons(3).map do |window|
  (window.sum / 3.0).round(2)
end
puts "3-period moving averages: #{averages.inspect}"

# step - iterate with step size
puts "\nstep (every 2nd element):"
(0..10).step(2) do |n|
  print "#{n} "
end
puts

# upto and downto
puts "\nupto (1 to 5):"
1.upto(5) { |n| print "#{n} " }
puts

puts "\ndownto (5 to 1):"
5.downto(1) { |n| print "#{n} " }
puts

# times
puts "\ntimes (repeat 3 times):"
3.times { |i| puts "  Iteration #{i}" }

# Combining methods
puts "\nCombining methods:"
result = (1..10)
  .select(&:even?)
  .map { |n| n * 2 }
  .each_slice(2)
  .map { |pair| pair.sum }
puts "Result: #{result.inspect}"

# each_with_object for grouping
puts "\nGrouping with each_with_object:"
words = %w[apple apricot banana blueberry cherry]
grouped = words.each_with_object({}) do |word, hash|
  first_letter = word[0]
  hash[first_letter] ||= []
  hash[first_letter] << word
end
puts grouped.inspect

# partition - split based on condition
puts "\npartition (split even/odd):"
numbers = [1, 2, 3, 4, 5, 6]
evens, odds = numbers.partition(&:even?)
puts "Evens: #{evens.inspect}"
puts "Odds: #{odds.inspect}"

# group_by
puts "\ngroup_by (group by length):"
words = %w[a bb ccc dd eee f]
by_length = words.group_by(&:length)
puts by_length.inspect

# chunk - group consecutive elements
puts "\nchunk (group consecutive by even/odd):"
[1, 2, 4, 6, 7, 8, 9, 10].chunk(&:even?).each do |is_even, numbers|
  puts "  #{is_even ? 'Even' : 'Odd'}: #{numbers.inspect}"
end

# slice_before and slice_after
puts "\nslice_before (split on condition):"
[1, 2, 3, 0, 4, 5, 0, 6, 7].slice_before(0).each do |chunk|
  puts "  #{chunk.inspect}"
end

# lazy iteration (infinite sequences)
puts "\nlazy (infinite sequence):"
result = (1..)
  .lazy
  .select { |n| n % 3 == 0 }
  .map { |n| n * 2 }
  .first(5)
puts "First 5 multiples of 3, doubled: #{result.inspect}"

# tally (Ruby 2.7+)
puts "\ntally (count occurrences):"
letters = %w[a b c a b a d e b]
puts letters.tally.inspect

# each_entry (for nested structures)
puts "\neach_entry (for nested):"
[[1, 2], [3, 4], [5, 6]].each_entry do |a, b|
  puts "  #{a} + #{b} = #{a + b}"
end
