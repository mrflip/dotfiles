#!/usr/bin/env ruby
require 'set'

# cat ~/history-bash/hist-* | ~/bin/cull_hist_sorted.rb > ~/history-bash/all/hist-`datename`-all.hist

lines = STDIN.readlines
          .map{|ll| ll.chars.select(&:valid_encoding?).join }
          .map(&:chomp);

ulines = Set.new()
lines.each do |line|
  ulines.delete(line)
  ulines << line
end


key         = '2000-00-00'
groups      = {};
groups[key] = [];

ulines.map do |ll|
  if (ll =~ /\#\#\#+ ([\d\-]+.*) \#\#\#+/) then
    key         = $1
    groups[key] = []
  end
  groups[key].push(ll)
end

groups.map.sort.map{|kk,lls|
  # next unless (kk =~ /^(201[789]|2020)/)
  puts lls
}
