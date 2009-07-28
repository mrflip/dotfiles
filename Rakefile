require 'rake'

DONOTINSTALL = %w[Rakefile README LICENSE bin]

def home_dot file
  File.join(ENV['HOME'], ".#{file}")
end

directory File.join(ENV['HOME'], 'bin')

%w[wgetrc.d history-irb history-bash].each do |dir|
  directory home_dot(dir)
end

desc "install the dot files into user's home directory"
task :install do
  replace_all = false
  (Dir['*'] - DONOTINSTALL).sort.each do |file|

    if File.exist?(home_dot(file))
      case
      when replace_all
        replace_file(file)
      when File.symlink?(home_dot(file)) && link_is_same(file)
        replace_file(file, :quiet)
      when File.symlink?(home_dot(file))
        puts "#{home_dot(file)} is a symlink, discarding (it pointed to #{})"
        replace_file(file)
      else
        print "overwrite ~/.#{file}? [ynaq] "
        case $stdin.gets.chomp
        when 'a'
          replace_all = true
          replace_file(file)
        when 'y'
          replace_file(file)
        when 'q'
          exit
        else
          puts "skipping ~/.#{file}"
        end
      end
    else
      link_file(file)
    end
  end
end

def link_is_same(file)
  return false unless File.symlink?(home_dot(file))
  src  = File.expand_path file
  dest = File.expand_path File.readlink(home_dot(file))
  src == dest
end

def move_file_away(file)
  FileUtils.mkdir_p '/tmp/dotfiles/'
  away = File.join '/tmp/dotfiles', file+'-'+Time.now.strftime("%Y%m%d-%H%M%S")
  FileUtils.mv home_dot(file), away
  puts "moved it to #{away} in case you change your mind."
end

def replace_file(file, quiet = false)
  # just kill symlinks, move files/dirs away
  if File.symlink?(home_dot(file))
    FileUtils.rm   home_dot(file)
  else
    move_file_away file
  end
  link_file(file, quiet)
end

def link_file(file, quiet = false)
  puts "linking ~/.#{file}" unless quiet == :quiet
  system %Q{ln -s "$PWD/#{file}" "$HOME/.#{file}"}
end
