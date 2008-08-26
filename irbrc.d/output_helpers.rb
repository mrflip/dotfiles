# included by .irbrc
# gotten from someone on dotfiles

# Colorize results
begin
  require 'rubygems'
  require 'wirble'
  Wirble.init
  Wirble.colorize
rescue LoadError
  puts "Error loading Wirble. Run 'sudo gem install wirble' to enable colorized results."
end


# # Add .ri method to all objects
# class Object
#   # print documentation
#   #
#   #   ri 'Array#pop'
#   #   Array.ri
#   #   Array.ri :pop
#   #   arr.ri :pop
#   def ri(method = nil)
#     unless method && method =~ /^[A-Z]/ # if class isn't specified
#       klass = self.kind_of?(Class) ? name : self.class.name
#       method = [klass, method].compact.join('#')
#     end
#     puts `ri '#{method}'`
#   end
# end


# Inline colorized ri (override wirble's)
RIARGS = ['-f', 'ansi']
require 'rdoc/ri/ri_driver'
class MyStupidRiDriver < RiDriver
  def self.ri(*topics)
    topics.map! { |topic| topic.to_s }
    begin
      MyStupidRiDriver.new(*topics).process_args
    rescue => e
      puts "Error processing ri request: #{e}"
    end
  end

  def initialize(*topics)
    @options = RI::Options.instance
    args = RIARGS.dup + topics
    @options.parse(args)
    paths = RI::Paths::PATH
    @ri_reader = RI::RiReader.new(RI::RiCache.new(paths))
    @display   = @options.displayer
  end
end

def Kernel.ri(*args)
  less { MyStupidRiDriver.ri(*args) }
end

class Module
  def ri(*args)
    topics = args.map { |arg| arg = "#{self}##{arg}" }
    less { MyStupidRiDriver.ri(*topics) }
  end
end


# Copious output helper
def less
  spool_output('less')
end

def most
  spool_output('most')
end

def spool_output(spool_cmd)
  require 'stringio'
  $stdout, sout = StringIO.new, $stdout
  yield
  $stdout, str_io = sout, $stdout
   IO.popen(spool_cmd, 'w') do |f|
     f.write str_io.string
     f.flush
     f.close_write
   end
end

# Simple regular expression helper
# show_regexp - stolen from the pickaxe
def show_regexp(a, re)
   if a =~ re
      "#{$`}<<#{$&}>>#{$'}"
   else
      "no match"
   end
end

# Convenience method on Regexp so you can do
# /an/.show_match("banana")
class Regexp
   def show_match(a)
       show_regexp(a, self)
   end
end

puts "Hi from #{__FILE__}"
