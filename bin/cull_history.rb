#!/usr/bin/env ruby
require 'fileutils'
require 'set'
require 'configliere'; Settings.use :commandline

Settings.define :hist_dir,    :type => :filename, :default => File.dirname( ENV['HISTFILE'] ), :description => 'The directory to cull. Taken from $HISTFILE by default.'
Settings.define :hist_file,   :type => :filename, :default => nil,                             :description => 'A single file to cull. Otherwise everything in --hist_dir is culled.'
Settings.define :clobber,     :type => :boolean,  :default => false, :description => "Write to copies of the history files (and not directly into the --hist_dir"
Settings.resolve!

def tmp_dir(slug)
  dir = "/tmp/cull_history-#{slug}-#{Time.now.strftime("%Y%m%d%h%m%s")}-#{$$}"
  FileUtils.mkdir_p dir
  dir
end

BKUP_DIR = tmp_dir('bkup')
$stderr.puts "Placing old history files in #{BKUP_DIR}..."

if Settings.clobber
  DEST_DIR = Settings.hist_dir
  $stderr.puts "Overwriting history files in #{DEST_DIR}..."
else
  DEST_DIR = tmp_dir('cull')
  $stderr.puts "Writing history files to #{DEST_DIR}... Re-run with --clobber to update #{DEST_DIR}"
end

# Track each unique line
lines = Set.new

if Settings.hist_file
  hist_files = [Settings.hist_file]
else
  hist_files = Dir[File.join(Settings.hist_dir, '*.hist')]
end

hist_files.sort.reverse.each do |hist_file|
  dest_file = File.join(DEST_DIR, File.basename(hist_file))
  bkup_file = File.join(BKUP_DIR, File.basename(hist_file))
  FileUtils.cp hist_file, bkup_file
  uniq_lines = 0 ; total_lines = 0
  File.open(dest_file, 'w') do |out_file|
    rev_lines = File.readlines(bkup_file).reverse.map do |line|
      total_lines += 1
      next if lines.include?(line) ; uniq_lines += 1
      lines    << line
    end
    rev_lines.each{|line| out_file << line }
  end
  $stderr.puts "  #{uniq_lines}\t#{total_lines}\t#{hist_file}\t#{dest_file}"
end
