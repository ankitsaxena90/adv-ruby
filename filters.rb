module Filters
  $before_only_methods = []
  $before_filters = []
  $before_except_methods = []

  $after_only_methods = []
  $after_filters = []
  $after_except_methods = []

  def self.included(klass)
    klass.const_set(:METHOD_HASH, {})

    def klass.method_added(name)
      return if @_adding_a_method
      @_adding_a_method = true
      Filters.wrap_method(self, name)
      @_adding_a_method = false
    end
   
    def klass.before_filter(*args)
      args.each do |arg|
        if arg.class == Hash
          if arg.has_key?(:only)
            $before_only_methods.concat(arg[:only])
          elsif arg.has_key?(:except)
            $before_except_methods.concat(arg[:except])
          end
        else
          $before_filters << arg if !($before_filters.include?(arg))
        end
      end
    end

    def klass.after_filter(*args)
      args.each do |arg|
        if arg.class == Hash
          if arg.has_key?(:only)
            $after_only_methods.concat(arg[:only])
          elsif arg.has_key?(:except)
            $after_except_methods.concat(arg[:except])
          end
        else
          $after_filters << arg if !($after_filters.include?(arg))
        end
      end
    end
  end

  def self.wrap_method(klass, method)
    method_hash = klass.const_get(:METHOD_HASH, {})
    method_hash[method] = klass.instance_method(method)
    body = %{
      def #{method}(*args, &block)
        run_methods = []
        if (($before_only_methods.empty?) && ($before_except_methods.empty?) && ($after_only_methods.empty?) && ($after_except_methods.empty?) )
          run_methods.concat($before_filters)
          run_methods.concat([:#{method}])
          run_methods.concat($after_filters)
          
        elsif (($before_only_methods.empty?) || ($before_only_methods.include?(:#{method}))  && !($before_except_methods.include?(:#{method})) && !($before_filters.include?(:#{method})))
          run_methods.concat($before_filters)
          run_methods.concat([:#{method}])
       
          if ( (($after_only_methods.empty?) || ($after_only_methods.include?(:#{method})) ) && (!($after_except_methods.include?(:#{method})) && !($after_filters.include?(:#{method}))) )
            puts "except methods #{$after_except_methods}"
            puts !($after_except_methods.include?(:#{method}))
            run_methods.concat($after_filters)
          end

        elsif ( ($after_only_methods.empty?) || ($after_only_methods.include?(:#{method})) )
          if !($after_except_methods.include?(:#{method})) && !($after_filters.include?(:#{method}))
            run_methods.concat([:#{method}])
            run_methods.concat($after_filters)
          else
            run_methods.concat([:#{method}])
          end
        end

        run_methods.each do |methods|
          puts methods
        end
      end
    }
    #puts body
    klass.class_eval body
  end
end


class Hello
  include Filters
  before_filter :first_filter, :second_filter, :only => [:hello_world]
  after_filter :done, :except => [:hello_world, :language]

  def first_filter
    puts "Filter 1"
  end
  def second_filter
    puts "Filter 2"
  end

  def hello_world
    puts "Hello World"
  end
  def language
    puts "Using Ruby Language"
  end

  def done
    puts "Method Executed"
  end
end
h = Hello.new
h.hello_world
puts
h.language
puts
h.first_filter