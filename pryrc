# -*- ruby -*-

CONSOLE_HELPERS_DIR = File.expand_path('~/.irbrc.d')     unless defined?(CONSOLE_HELPERS_DIR)
CONSOLE_HIST_DIR    = File.expand_path('~/.history-irb') unless defined?(CONSOLE_HIST_DIR)
CONSOLE_HIST_FILE   = File.join(CONSOLE_HIST_DIR, 'history_ruby_'+Time.now.utc.strftime('%Y_%W')+'.hist') unless defined?(CONSOLE_HIST_FILE)

def safely_require gem, &block
  begin
    require gem
    block.call if block
  rescue LoadError => e ; puts e ; end
end

#
# Infinite rolling history
#
unless File.exists?(CONSOLE_HIST_FILE)
  require 'fileutils'
  FileUtils.mkdir_p(CONSOLE_HIST_DIR)
  last_hist_file = Dir[File.join(CONSOLE_HIST_DIR,'/history_ruby_*')].sort.last
  FileUtils.cp(last_hist_file, CONSOLE_HIST_FILE) if last_hist_file
end
Pry.config.history_file = CONSOLE_HIST_FILE

#
# Pry extensions
#

Pry.class_eval do
  def self.add_hook(hook_name, &blk)
    old_hook = Pry.hooks[hook_name]
    self.hooks[hook_name] = Proc.new do |out, obj|
      old_hook.call(out, obj) if old_hook
      blk.call(out, obj)
    end
  end
end


#
# Console Helpers
#

# safely_require('ap')
# safely_require('hirb') do
#   Pry.config.print = lambda{|out,val| Hirb::View.view_or_page_output(val) || Pry::DEFAULT_PRINT.call(out, val) }
# end
safely_require(File.join(CONSOLE_HELPERS_DIR, 'toy'))
safely_require(File.join(CONSOLE_HELPERS_DIR, 'history_deduper'))
# safely_require(File.join(CONSOLE_HELPERS_DIR, 'rails_console'))


if defined?(Rails) && Rails.env
  # loading rails configuration if it is running as a rails console
  load(ENV['HOME']+'/.railsrc')
  extend Rails::ConsoleMethods if defined?(Rails::ConsoleMethods) # rails 3.2+
end


#
# Pry
#

Pry.config.editor = lambda{|f,l| "open -a Emacs #{f}" }
Pry.config.prompt = Pry::Prompt.new(
  "flip", "custom", [
    lambda{|obj, level, *_| "#{RUBY_VERSION} #{obj.to_s[0..60]}:#{level}> " }, 
    lambda{|obj, level, *_| "#{RUBY_VERSION} #{obj.to_s[0..40]}:#{level} ...> " }
  ]
)

Pry.config.exception_handler = proc do |output, exception, _|
  output.puts "#{exception.class}: #{exception.message}"
  output.puts "  #{exception.backtrace.first(3).join("\n  ")}"
end
