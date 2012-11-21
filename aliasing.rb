module MyModule
  def self.included(klass)
    def klass.chained_aliasing(func_name, type)
      scope = MyModule.get_scope(func_name, self)
      original_method = "original_#{func_name}"
      alias_method original_method, func_name
      special_char = "?" if func_name[-1,1] == '?'
      special_char = "!" if func_name[-1,1] == '!'

      org_meth =  func_name.to_s.chop!
    
      method_with = org_meth + "_with_#{type}" + special_char
      method_without = org_meth + "_without_#{type}" + special_char

      class_eval %{ #{scope}
      def #{func_name}
        puts '--logging start'
        #{original_method}
        puts "--logging end"
      end
      }
      #puts body
      #class_eval body
      alias_method "#{method_with}", "#{func_name}"
      class_eval %{ #{scope}
        def #{method_without}
        #{original_method}
      end
      } 
    end
  end
  def self.get_scope(func_name, klass)
    return :public if klass.public_method_defined?(func_name)
    return :private if klass.private_method_defined?(func_name)
    :protected
  end
end

class Hello
  include MyModule
  def greet?
    puts "Hello"
  end
  chained_aliasing :greet?, :logger
end

say = Hello.new
puts "Simple Method"
say.greet?
puts "\nMethod With Logger"
say.greet_with_logger?
puts "\nMethod Without Logger"
say.greet_without_logger?