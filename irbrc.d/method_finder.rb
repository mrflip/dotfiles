# included by .irbrc
# http://www.nobugs.org/developer/ruby/method_finder.html

class Object
  # Clone fails on numbers, but they're immutable anyway
  def megaClone
    begin self.clone; rescue; self; end
  end

  def what?(*a)
    MethodFinder.new(self, *a)
  end

  # list methods which aren't in superclass
  def local_methods(obj = self)
    (obj.methods - obj.class.superclass.instance_methods).sort
  end
end

class MethodFinder
  # Find all methods on [anObject] which, when called with [args] return [expectedResult]
  def self.find( anObject, expectedResult, *args )
    anObject.methods.select { |name| anObject.method(name).arity == args.size }.
                     select { |name| begin anObject.megaClone.method( name ).call(*args) == expectedResult;
                                     rescue; end }
  end

  # Pretty-prints the results of the previous method
  def self.show( anObject, expectedResult, *args )
    find( anObject, expectedResult, *args ).each { |name|
      print "#{anObject.inspect}.#{name}"
      print "(" + args.map { |o| o.inspect }.join(", ") + ")" unless args.empty?
      puts " == #{expectedResult.inspect}"
    }
  end

  def initialize( obj, *args )
    @obj = obj
    @args = args
  end

  def ==( val )
    MethodFinder.show( @obj, val, *@args )
  end

end
