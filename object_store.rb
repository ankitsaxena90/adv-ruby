module MyObjectStore
  $object_array = []
  def validate_presence_of(fname, mail)
    if self.fname.empty? || self.age.nil?
      return puts "#{self} can't be saved"
    end
    return true
  end
  def save
    $object_array << self if validate 
  end

  def self.included(klass)
    klass.extend ClassMethods
  end

  module ClassMethods
    def count
      puts $object_array.length
    end

    def collect
      $object_array.each do |value|
        print value, " "
      end
      puts
    end
    def attr_accessor(*args)
      args.each do |attr|
        instance_eval %{
        def find_by_#{attr}(val)
          filtered_obj = []
          $object_array.select do |obj|
            filtered_obj << obj if obj.#{attr}.eql?(val)
          end
          filtered_obj
        end
        }
      end
      super
    end
  end
end


class Play
  include MyObjectStore
  attr_accessor :age, :fname, :email

  def validate
    validate_presence_of :fname, :mail
  end
end
p2 = Play.new
p2.fname = "Ray"
p2.age = 25
p2.email = "x@ymail.com"
p2.save

p3 = Play.new
p3.fname = "Maverick"
p3.age = 22
p3.email = "m@cs.com"
p3.save
Play.collect
Play.count
print "Find by fname :"
puts Play.find_by_fname("Ray")
print "Find by email :"
puts Play.find_by_email("m@cs.com")