def create_class(class_name)
  klass = Object.const_set(class_name, Class.new)
  klass.class_eval do
    define_method(:initialize) do |fields, name|
      instance_variable_set("@instances", name)
      name.each_with_index do |name, i|
        instance_variable_set("@" + name, fields[i])
        #puts "value[#{i}] = #{values[i]}"
      end
    end
  end
  return klass
end

def create_object(cls, rows)
  class_objects = []
  1.upto(rows.length - 1) do |i|
    class_objects[i - 1] = cls.new(rows[i], rows[0])
  end
  puts class_objects.inspect
end


puts "Enter the name of the file (e.g persons.csv)"
file_name = gets.chomp
#class_name =  File.basename(file_name, ".csv")
class_name = file_name.gsub(".csv","").capitalize!

read_file = File.open(file_name, "r")
rows = []
read_file.each_line { |line| 
  fields = []
  line.split(",").each do |val|
    fields << val.strip
  end
  rows.push(fields)
}

cls = create_class(class_name)
create_object(cls, rows)
