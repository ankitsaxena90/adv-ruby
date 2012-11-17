str1 = "Sony"
str2 = "Nokia"

def str1.os_type
  puts "Android"
end

class << str1
  def version
    puts "Jelly Bean"
  end
end

str1.os_type
str1.version

str2.os_type
str2.version