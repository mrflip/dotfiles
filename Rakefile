require 'rake'

DONOTINSTALL = %w[Rakefile README LICENSE bin]

def home_dot file
  File.join(ENV['HOME'], ".#{file}")
end

def home file
  File.join(ENV['HOME'], file)
end

%w[wgetrc.d history-irb history-bash].each do |dir|
  directory home_dot(dir)
  task :install => home_dot(dir)
end


desc "install the dot files into user's home directory"
task :install do
  $replace_all = false
  (Dir['*'] - DONOTINSTALL).sort.each do |src|
    link_from src, home_dot(src)
  end
  # Don't prefix these with a "."
  %w[bin].each do |src|
    link_from src, home(src)
  end
end

def link_from src, dest, replace=false
  if File.exist?(dest)
    case
    when $replace_all
      replace_file(src, dest)
    when File.symlink?(dest) && link_is_same(src, dest)
      replace_file(src, dest, :quiet)
    when File.symlink?(dest)
      puts "#{dest} is a symlink, discarding (it pointed to #{`ls -l #{dest}`})" ;
      replace_file(src, dest)
    else # prompt
      print "overwrite #{dest}? [ynaqd] "
      case $stdin.gets.chomp
      when 'a'
        $replace_all = true
        replace_file(src, dest)
      when 'd'
        system('diff', '-uw', dest, src)
        redo
      when 'y'
        replace_file(src, dest)
      when 'q'
        exit
      else
        puts "skipping #{dest}"
      end
    end
  else # file doesn't exist
    link_file(src, dest)
  end
end

def link_is_same(src, dest)
  return false unless File.symlink?(dest)
  src  = File.expand_path src
  dest = File.expand_path File.readlink(dest)
  src == dest
end

def move_file_away(dest)
  FileUtils.mkdir_p '/tmp/dotfiles/'
  away = File.join '/tmp/dotfiles', File.basename(dest)+'-'+Time.now.strftime("%Y%m%d-%H%M%S")
  FileUtils.mv dest, away
  puts "moved it to #{away} in case you change your mind."
end

def replace_file(src, dest, quiet = false)
  # just kill symlinks, move files/dirs away
  if File.symlink?(dest)
    FileUtils.rm   dest
  else
    move_file_away dest
  end
  link_file(src, dest, quiet)
end

def link_file(src, dest, quiet = false)
  puts "linking #{dest}" unless quiet == :quiet
  src  = File.expand_path src
  system %Q{ln -s #{src} #{dest}}
end
