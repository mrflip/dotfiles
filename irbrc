#!/usr/bin/ruby
require 'irb/completion'
require 'irb/ext/save-history'
require 'date'

IRB.conf[:SAVE_HISTORY] = 10000
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.history-irb/history_ruby_" + (Date::today.strftime('%Y_%W'))
IRB.conf[:PROMPT_MODE]  = :DEFAULT
IRB.conf[:AUTO_INDENT]   = true
IRB.conf[:IGNORE_SIGINT] = true

[:historian, :method_finder, :output_helpers, :textmate].each do |irbrc_file|
  require ENV['HOME'] + "/.irbrc.d/#{irbrc_file}.rb"
end
load File.dirname(__FILE__) + '/.railsrc' if $0 == 'irb' && ENV['RAILS_ENV']
