#!/usr/bin/ruby
require 'irb/completion'
require 'irb/ext/save-history'
require 'date'

IRB.conf[:SAVE_HISTORY] = 10000
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.history-irb/history_ruby_" + (Date::today.strftime('%Y_%W'))
IRB.conf[:PROMPT_MODE]  = :DEFAULT
IRB.conf[:AUTO_INDENT]   = true
IRB.conf[:IGNORE_SIGINT] = true

%w[rubygems looksee/shortcuts wirble].each do |gem|
  begin ; require gem  ;  rescue LoadError ; end
end

# , :textmate
[:historian, :method_finder, :output_helpers, :rails_console_helpers].each do |irbrc_file|
  begin ; require ENV['HOME'] + "/.irbrc.d/#{irbrc_file}.rb" ; rescue LoadError ; end
end
IRB.conf[:PROMPT_MODE] = :SIMPLE

load File.dirname(__FILE__) + '/.railsrc' if $0 == 'irb' && ENV['RAILS_ENV']
