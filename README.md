# Ruby Tricks

An homage to Peter Cooper's excellent video: [Ruby Trick Shots: 24 Ruby Language Tips and Tricks](https://www.youtube.com/watch?v=gIEMKOI_Y-4)

This repository contains 24 runnable Ruby code examples demonstrating powerful Ruby language features, idioms, and tricks. Each file includes detailed explanations and practical examples.

## 🚀 Quick Start

Clone the repository and run any trick:

```bash
git clone https://github.com/corsonknowles/ruby_tricks.git
cd ruby_tricks
ruby tricks/01_symbol_to_proc.rb
```

## 📚 The 24 Tricks

### 1. [Symbol to Proc](tricks/01_symbol_to_proc.rb)
Convert symbols to procs for concise method calls using `&:method_name`.
```ruby
[1, 2, 3].map(&:to_s)  # ["1", "2", "3"]
```

### 2. [Percent Notation](tricks/02_percent_notation.rb)
Use `%w`, `%i`, `%W`, `%I`, and other percent notations for cleaner array and string literals.
```ruby
%w[apple banana cherry]  # ["apple", "banana", "cherry"]
%i[foo bar baz]          # [:foo, :bar, :baz]
```

### 3. [String Interpolation](tricks/03_string_interpolation.rb)
Embed expressions directly in strings using `#{}`.
```ruby
name = "Ruby"
"Hello, #{name}!"  # "Hello, Ruby!"
```

### 4. [Ranges and Enumerable](tricks/04_ranges.rb)
Create sequences and check membership with ranges.
```ruby
(1..5).to_a           # [1, 2, 3, 4, 5]
(18..65).include?(25) # true
```

### 5. [Multiple Assignment](tricks/05_multiple_assignment.rb)
Assign multiple variables at once, swap without temp variables.
```ruby
a, b = 1, 2
a, b = b, a  # Swap!
first, *rest = [1, 2, 3, 4]
```

### 6. [Safe Navigation Operator](tricks/06_safe_navigation.rb)
Prevent `NoMethodError` when calling methods on `nil` using `&.`.
```ruby
user&.profile&.email  # Returns nil if any step is nil
```

### 7. [tap Method](tricks/07_tap_method.rb)
Yield self to a block, then return self - perfect for chaining and debugging.
```ruby
result = [1, 2, 3]
  .tap { |arr| puts "Processing: #{arr}" }
  .map { |n| n * 2 }
```

### 8. [Bang (!) Methods](tricks/08_bang_methods.rb)
Methods ending with `!` modify objects in-place (destructive operations).
```ruby
str = "hello"
str.upcase!  # Modifies str
str          # "HELLO"
```

### 9. [Hash Default Values](tricks/09_hash_default_values.rb)
Set default values for missing hash keys.
```ruby
count = Hash.new(0)
count[:missing]  # 0, not nil
```

### 10. [Keyword Arguments](tricks/10_keyword_arguments.rb)
Make method signatures clearer with named parameters.
```ruby
def greet(name:, greeting: "Hello")
  "#{greeting}, #{name}!"
end
```

### 11. [Array Coercion](tricks/11_array_coercion.rb)
Safely convert values to arrays with `Array()`.
```ruby
Array(nil)      # []
Array(42)       # [42]
Array([1, 2])   # [1, 2]
```

### 12. [Splat Operator (*)](tricks/12_splat_operator.rb)
Handle variable arguments and array expansion.
```ruby
def sum(*numbers)
  numbers.reduce(:+)
end

arr = [1, 2, 3]
add(*arr)  # Expands to add(1, 2, 3)
```

### 13. [Dynamic Method Calling with send](tricks/13_send_method.rb)
Call methods dynamically using strings or symbols.
```ruby
calc.send(:add, 5, 3)  # Same as calc.add(5, 3)
```

### 14. [method_missing](tricks/14_method_missing.rb)
Intercept calls to undefined methods for metaprogramming.
```ruby
def method_missing(method, *args)
  # Handle dynamic methods
end
```

### 15. [Blocks and Yield](tricks/15_blocks_and_yield.rb)
Pass behavior to methods using blocks.
```ruby
def greet
  puts "Hello"
  yield
  puts "Goodbye"
end
```

### 16. [Inline Rescue](tricks/16_inline_rescue.rb)
Handle exceptions inline without `begin/end` blocks.
```ruby
result = Integer("abc") rescue 0
```

### 17. [Open Classes (Monkey Patching)](tricks/17_open_classes.rb)
Add or modify methods in existing classes.
```ruby
class String
  def shout
    "#{upcase}!"
  end
end
```

### 18. [Method Aliasing](tricks/18_method_aliasing.rb)
Create alternative names for methods.
```ruby
alias_method :old_method, :new_method
```

### 19. [require_relative](tricks/19_require_relative.rb)
Load files relative to the current file's location.
```ruby
require_relative 'lib/helper'
require_relative '../config/settings'
```

### 20. [__FILE__ and __LINE__](tricks/20_file_and_line.rb)
Special constants for introspection and debugging.
```ruby
puts "Error at #{__FILE__}:#{__LINE__}"
```

### 21. [unless and until](tricks/21_unless_until.rb)
Negative conditionals that read naturally.
```ruby
unless condition
  # Runs when condition is false
end

until done
  # Loops until done is true
end
```

### 22. [Advanced Iteration Methods](tricks/22_advanced_iteration.rb)
`each_with_index`, `each_slice`, `each_cons`, and more.
```ruby
[1, 2, 3, 4].each_slice(2) { |pair| puts pair.inspect }
[1, 2, 3, 4, 5].each_cons(3) { |triple| puts triple.inspect }
```

### 23. [Singleton Methods](tricks/23_singleton_methods.rb)
Add methods to individual objects, not the entire class.
```ruby
str = "hello"
def str.shout
  upcase + "!!!"
end
```

### 24. [Advanced Splat and Parallel Assignment](tricks/24_advanced_splat.rb)
Advanced uses of multiple assignment and splat operators.
```ruby
first, *middle, last = [1, 2, 3, 4, 5]
a, b, c = b, c, a  # Rotate values
```

## 🎯 Running All Examples

You can run all examples at once:

```bash
for file in tricks/*.rb; do
  echo "========================================"
  echo "Running: $file"
  echo "========================================"
  ruby "$file"
  echo ""
done
```

Or run individual tricks:

```bash
ruby tricks/01_symbol_to_proc.rb
ruby tricks/06_safe_navigation.rb
ruby tricks/15_blocks_and_yield.rb
```

## 📖 Learning Path

If you're new to Ruby, we recommend exploring the tricks in this order:

**Beginner:**
1. String Interpolation (#3)
2. Ranges (#4)
3. Multiple Assignment (#5)
4. Blocks and Yield (#15)

**Intermediate:**
5. Symbol to Proc (#1)
6. Safe Navigation (#6)
7. tap Method (#7)
8. Hash Default Values (#9)
9. Keyword Arguments (#10)

**Advanced:**
10. Splat Operator (#12)
11. Dynamic Method Calling (#13)
12. method_missing (#14)
13. Singleton Methods (#23)

## 🤝 Contributing

Feel free to submit pull requests with improvements, additional examples, or corrections!

## 📺 Original Video

Check out the original video by Peter Cooper: [Ruby Trick Shots: 24 Ruby Language Tips and Tricks](https://www.youtube.com/watch?v=gIEMKOI_Y-4)

## 📝 License

See [LICENSE](LICENSE) file for details.

## 🙏 Credits

- Peter Cooper for the original video
- The Ruby community for these wonderful language features
