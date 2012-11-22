@regex = /^[qQ]$/
$array = []
def take_input
  puts "Enter some Code (q/Q) to quit the program or Press Enter to evaluate"
  input = gets.chomp
  $array.push(input.to_s)
  checkInput(input.to_s)
end

def checkInput(str)
  if str.match(@regex)
    puts "Bye"
    exit(0)
  elsif str.length == 0
    puts eval $array.join
    $array.clear
  else
    take_input()
  end
end

take_input()