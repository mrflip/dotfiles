#!/usr/bin/env ruby
require 'fileutils'
require 'set'

HIST_DIR = File.dirname( ENV['HISTFILE'] )
TMP_DIR = "/tmp/cull_history-#{Time.now.strftime("%Y%m%d%h%m%s")}-#{$$}"
FileUtils.mkdir_p TMP_DIR
$stderr.puts "Placing old history files in #{TMP_DIR}..."

# Track each unique line
lines = Set.new

Dir[HIST_DIR+'/hist-*'].sort.each do |hist_file|
  uniq_lines = 0 ; total_lines = 0
  orig_file = File.join(TMP_DIR, File.basename(hist_file))
  FileUtils.cp hist_file, orig_file
  File.open(hist_file, 'w') do |out_file|
    File.open(orig_file).each do |line|
      total_lines += 1
      next if lines.include?(line) ; uniq_lines += 1
      lines    << line
      out_file << line
    end
  end
  $stderr.puts "  #{uniq_lines}\t#{total_lines}\t#{hist_file}"
end
