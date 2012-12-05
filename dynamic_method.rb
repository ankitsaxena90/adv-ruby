class StringSubclass < String

  def palindrome
    if self.reverse == self
      puts "#{ self } is palindrome."
    else
      puts "#{ self } is not palindrome."
    end
  end

  def inverse
    puts "Inversed String is: #{self.swapcase}"
  end

end



puts "Enter the name of the object to be created"
object_name = gets.chomp
obj1 = StringSubclass.new(object_name)

puts "Select any method to be performed 'inverse' / 'palindrome' "
method_name = gets.chomp.to_s

obj1.send(method_name)
