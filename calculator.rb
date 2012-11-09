class Calculator
	def calculate(op1, op , op2)
		print "#{op1} #{op} #{op2} = "
		puts eval "#{op1}" + "#{op}" + "#{op2}"
	end
end

puts "Enter first Operand"
op1 = gets.chomp

puts "Enter the operator(+,-,/,*)"
op = gets.chomp

puts "Enter second Operand"
op2 = gets.chomp.to_f

c = Calculator.new
c.calculate(op1,op,op2)