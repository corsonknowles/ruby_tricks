#!/usr/bin/env ruby
# Trick #2: Percent Notation for Arrays
# Use %w for word arrays, %i for symbol arrays, %W and %I for interpolation

# %w creates an array of strings (no quotes needed)
puts "String array with %w:"
words = %w[apple banana cherry]
p words

# %i creates an array of symbols
puts "\nSymbol array with %i:"
symbols = %i[foo bar baz]
p symbols

# %W allows interpolation
name = "ruby"
puts "\nInterpolated array with %W:"
interpolated = %W[hello #{name} world]
p interpolated

# %I for interpolated symbols
puts "\nInterpolated symbols with %I:"
sym_interpolated = %I[#{name}_method #{name}_class]
p sym_interpolated

# Other percent notations
puts "\nRegex with %r:"
regex = %r{https?://\w+}
p regex

puts "\nString with %q (no interpolation):"
p %q[This won't interpolate: #{name}]

puts "\nString with %Q (with interpolation):"
p %Q[This will interpolate: #{name}]
