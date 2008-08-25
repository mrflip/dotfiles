# include this in .irbrc
# gotten from someone on dotfiles
require 'date'

begin
  if defined? Readline::HISTORY
    histfile = File::expand_path( IRB.conf[:HISTORY_FILE]  )
    if File::exists?( histfile )
      lines = IO::readlines( histfile ).collect {|line| line.chomp}
      lines = lines.to_a.reverse.uniq.reverse
      puts "Read %d saved history commands from %s." % [ lines.nitems, histfile ]
      Readline::HISTORY.push( *lines )
    else
      puts "History file '%s' was empty or non-existant." %
        histfile if $DEBUG || $VERBOSE
    end
    Kernel::at_exit do
      Readline::HISTORY = Readline::HISTORY.to_a.reverse.uniq.reverse
    end
  end
end
