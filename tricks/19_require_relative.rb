#!/usr/bin/env ruby
# Trick #19: require_relative
# Load files relative to the current file's location

puts "Trick #19: require_relative"
puts "\nrequire_relative loads files relative to the current file,"
puts "not relative to where the script is run from."
puts ""
puts "Example usage:"
puts "  require_relative 'lib/helper'"
puts "  require_relative '../config/settings'"
puts "  require_relative './models/user'"
puts ""

# Demonstrating the difference
puts "Current file: #{__FILE__}"
puts "Directory: #{File.dirname(__FILE__)}"

# Example 1: Creating helper files
helper_content = <<~RUBY
  module Helper
    def self.format_name(name)
      name.split.map(&:capitalize).join(' ')
    end
    
    def self.greeting(name)
      "Hello, \#{format_name(name)}!"
    end
  end
RUBY

# Create a temporary helper file to demonstrate require_relative behavior
# (fileutils not actually needed - using File.write instead)
helper_path = File.join(__dir__, 'helper_temp.rb')
File.write(helper_path, helper_content)

# Load with require_relative
require_relative 'helper_temp'

puts "\nUsing required helper:"
puts Helper.greeting("john doe")
puts Helper.format_name("alice smith")

# Clean up
File.delete(helper_path) if File.exist?(helper_path)

# Example 2: Understanding the difference
puts "\nrequire vs require_relative:"
puts ""
puts "require 'json'  # Loads from $LOAD_PATH (gems, stdlib)"
puts "require './file.rb'  # Loads relative to execution directory"
puts "require_relative 'file.rb'  # Loads relative to current file"
puts ""

# Example 3: Project structure
puts "Typical project structure:"
puts ""
puts "project/"
puts "├── lib/"
puts "│   ├── my_app.rb"
puts "│   ├── helpers.rb"
puts "│   └── models/"
puts "│       └── user.rb"
puts "└── bin/"
puts "    └── run.rb"
puts ""

puts "In lib/my_app.rb:"
puts "  require_relative 'helpers'"
puts "  require_relative 'models/user'"
puts ""

puts "In bin/run.rb:"
puts "  require_relative '../lib/my_app'"
puts ""

# Example 4: Loading multiple files
puts "Loading multiple files:"
files = %w[config helpers utils]
puts files.map { |f| "require_relative '#{f}'" }.join("\n  ")
puts ""

# Example 5: Circular dependencies warning
puts "⚠️  Watch out for circular dependencies:"
puts ""
puts "# file_a.rb"
puts "require_relative 'file_b'"
puts "class A; end"
puts ""
puts "# file_b.rb"
puts "require_relative 'file_a'"
puts "class B; end"
puts ""
puts "This will cause a LoadError!"
puts ""

# Example 6: Best practices
puts "Best practices:"
puts "1. Use require_relative for files in your project"
puts "2. Use require for gems and standard library"
puts "3. Organize files in a clear directory structure"
puts "4. Be careful with circular dependencies"
puts "5. Consider using a loader file to require all dependencies"
puts ""

# Example 7: Autoload as alternative
puts "Alternative: autoload (lazy loading)"
puts ""
puts "module MyApp"
puts "  autoload :User, 'my_app/user'"
puts "  autoload :Post, 'my_app/post'"
puts "end"
puts ""
puts "# Classes are loaded only when first used"
puts ""

# Example 8: Zeitwerk for modern Rails
puts "Modern approach (Rails 6+): Zeitwerk"
puts "Automatically loads files based on naming conventions"
puts "No need for manual requires in most cases!"
