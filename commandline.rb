def create_method(method_name, code)
	instance_eval "def #{method_name}
    puts eval '#{code}'
  end"
  puts "Call to the function #{method_name}"
end

puts "Enter the name for the method"
method_name = gets.chomp.to_s
puts "Enter the code"
code = gets.chomp.to_s
create_method(method_name, code)
instance_eval method_name