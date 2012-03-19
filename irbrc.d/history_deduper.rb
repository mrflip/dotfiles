#
# Clean up the history before exit
#

def uniq_by_last(list)
  seen = Hash.new
  uniq_list = list.to_a.reverse.reject do |line|
    dupe = seen.include?(line)
    seen[line] = true
    dupe
  end.reverse
  uniq_list
end

if  defined?(Readline::HISTORY)
  Readline::HISTORY.instance_eval do
    #
    # Scrubs duplicate lines from history
    #
    # @example
    #   "hi"
    #   "hi"
    #   "hi"
    #   p Readline::HISTORY.length # => 12142
    #   Readline::HISTORY.dedupe!
    #   p Readline::HISTORY.length # => 12139
    #
    def dedupe!
      # deduped_lines = uniq_by_last(self)
      # self.clear
      # deduped_lines.each{|line| self << line }
      length
    end
  end

  if    defined?(Pry)
    # Pry.add_hook(:after_session){ Readline::HISTORY.dedupe! }
  elsif defined?(IRB)
    IRB.conf[:AT_EXIT].unshift(lambda{ Readline::HISTORY.dedupe! })
  end
end
