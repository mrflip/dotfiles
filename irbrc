# -*- ruby -*-
require 'rubygems' unless defined?(Gem)

CONSOLE_HELPERS_DIR = File.expand_path('~/.irbrc.d')     unless defined?(CONSOLE_HELPERS_DIR)
CONSOLE_HIST_DIR    = File.expand_path('~/.history-irb') unless defined?(CONSOLE_HIST_DIR)
CONSOLE_HIST_FILE   = File.join(CONSOLE_HIST_DIR, 'history_ruby_'+Time.now.utc.strftime('%Y_%W')+'.hist') unless defined?(CONSOLE_HIST_FILE)

def safely_require gem, &block
  begin
    require gem
    block.call if block
  rescue LoadError => e ; puts "#{e.backtrace.join("\n")}: #{e}" ; end
end

#
# If pry, run that (it will source its own .pryrc)
#
safely_require('pry') do
  Pry.start
  exit
end

warn('No pry found! Enjoy boring old irb instead.')

#
# Console Helpers
#

require 'irb/completion'
require 'irb/ext/save-history'

IRB.conf[:SAVE_HISTORY] = 50_000
IRB.conf[:HISTORY_FILE] = CONSOLE_HIST_FILE
IRB.conf[:PROMPT_MODE]  = :DEFAULT
IRB.conf[:AUTO_INDENT]   = true
IRB.conf[:IGNORE_SIGINT] = true

require('rubygems')
safely_require('ap')
safely_require('hirb')
safely_require('looksee')
safely_require 'wirble' do
  Wirble.init(:skip_history => true)
  Wirble.colorize
end
safely_require(File.join(CONSOLE_HELPERS_DIR, 'toy'))
safely_require(File.join(CONSOLE_HELPERS_DIR, 'history_deduper'))
safely_require(File.join(CONSOLE_HELPERS_DIR, 'method_finder'))

# loading rails configuration if it is running as a rails console
load(ENV['HOME']+'/.railsrc') if defined?(Rails) && Rails.env
