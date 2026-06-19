#!/usr/bin/env ruby
# Trick #14: method_missing for Dynamic Methods
# Intercept calls to undefined methods for meta-programming magic

class DynamicHash
  def initialize
    @data = {}
  end
  
  def method_missing(method, *args)
    method_name = method.to_s
    
    if method_name.end_with?('=')
      # Setter
      key = method_name.chop.to_sym
      @data[key] = args.first
    elsif @data.key?(method)
      # Getter
      @data[method]
    else
      super
    end
  end
  
  def respond_to_missing?(method, include_private = false)
    method_name = method.to_s
    method_name.end_with?('=') || @data.key?(method) || super
  end
  
  def to_s
    @data.inspect
  end
end

puts "Dynamic hash example:"
config = DynamicHash.new
config.host = "localhost"
config.port = 3000
config.ssl = true
puts config.to_s
puts "Host: #{config.host}"
puts "Port: #{config.port}"

# Practical example: API client
class APIClient
  def method_missing(method, *args)
    endpoint = method.to_s
    puts "Making #{args[0] || 'GET'} request to /#{endpoint}"
    {endpoint: endpoint, method: args[0] || 'GET', params: args[1] || {}}
  end
  
  def respond_to_missing?(method, include_private = false)
    true  # Accept any method
  end
end

puts "\nAPI client example:"
api = APIClient.new
api.users('GET', {limit: 10})
api.posts('POST', {title: "Hello"})
api.comments

# Builder pattern
class HTMLBuilder
  def initialize
    @html = []
  end
  
  def method_missing(tag, *args, &block)
    attributes = args[0].is_a?(Hash) ? args[0] : {}
    content = args[0].is_a?(String) ? args[0] : args[1]
    
    @html << "<#{tag}#{format_attrs(attributes)}>"
    
    if block
      builder = HTMLBuilder.new
      builder.instance_eval(&block)
      @html << builder.to_s
    elsif content
      @html << content
    end
    
    @html << "</#{tag}>"
    self
  end
  
  def respond_to_missing?(method, include_private = false)
    true
  end
  
  def format_attrs(attrs)
    return '' if attrs.empty?
    ' ' + attrs.map { |k, v| "#{k}='#{v}'" }.join(' ')
  end
  
  def to_s
    @html.join
  end
end

puts "\nHTML builder example:"
html = HTMLBuilder.new
html.div(class: 'container') do
  h1 "Welcome"
  p "This is a paragraph"
end
puts html.to_s

# Warning: don't forget respond_to_missing?
class BadExample
  def method_missing(method, *args)
    "caught: #{method}"
  end
  # Missing respond_to_missing?
end

class GoodExample
  def method_missing(method, *args)
    "caught: #{method}"
  end
  
  def respond_to_missing?(method, include_private = false)
    true
  end
end

puts "\nrespond_to? behavior:"
bad = BadExample.new
good = GoodExample.new

puts "Bad responds to :foo? #{bad.respond_to?(:foo)}"
puts "Good responds to :foo? #{good.respond_to?(:foo)}"
