#!/usr/bin/env ruby
require 'fileutils'
require 'set'

HIST_DIR = File.dirname( ENV['HISTFILE'] )
TMP_DIR = "/tmp/cull_history-#{Time.now.strftime("%Y%m%d%h%m%s")}-#{$$}"
FileUtils.mkdir_p TMP_DIR
$stderr.puts "Placing new history files in #{TMP_DIR}..."

# Track each unique line
lines = Set.new

Dir[HIST_DIR+'/*'].sort.each do |hist_file|
  file_lines = 0
  File.open(File.join(TMP_DIR, File.basename(hist_file)), 'w') do |out_file|
    File.open(hist_file).each do |line|
      next if lines.include?(line)
      lines    << line
      out_file << line
      file_lines += 1
    end
  end
  $stderr.puts "  #{file_lines}\t#{hist_file}"
end
