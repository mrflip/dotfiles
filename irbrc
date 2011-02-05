#!/usr/bin/ruby
require 'irb/completion'
require 'irb/ext/save-history'
require 'date'

IRB.conf[:SAVE_HISTORY] = 10000
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.history-irb/history_ruby_" + (Date::today.strftime('%Y_%W'))
IRB.conf[:PROMPT_MODE]  = :DEFAULT
IRB.conf[:AUTO_INDENT]   = true
IRB.conf[:IGNORE_SIGINT] = true

def safely_require gem, &block
  begin
    require gem
    block.call if block
  rescue LoadError => e ; puts e ; end
end

def railsness
  case
  when ENV['RAILS_ENV']             then true
  when defined?(Rails) && Rails.env then true
  else false end
end

%w[rubygems looksee/shortcuts ap].each do |gem|
  safely_require gem
end

safely_require 'wirble' do
  Wirble.init
  Wirble.colorize
end

[:method_finder].each do |irb_helper|
  safely_require ENV['HOME']+"/.irbrc.d/#{irb_helper}.rb"
end
load File.dirname(__FILE__)+'/.railsrc' if railsness && File.exists?(File.dirname(__FILE__)+'/.railsrc')
