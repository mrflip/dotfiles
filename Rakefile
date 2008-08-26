require 'rake'

DONOTINSTALL = %w[Rakefile README LICENSE bin]

def home_dot file
  File.join(ENV['HOME'], ".#{file}")
end

directory File.join(ENV['HOME'], 'bin')

%w[wgetrc.d history-irb history-bash]
directory home_dot('wgetrc.d')

desc "install the dot files into user's home directory"
task :install do
  replace_all = false
  (Dir['*'] - DONOTINSTALL).each do |file|

    if File.exist?(home_dot(file))
      if replace_all
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

def replace_file(file)
  system %Q{rm "$HOME/.#{file}"}
  link_file(file)
end

def link_file(file)
  puts "linking ~/.#{file}"
  system %Q{ln -s "$PWD/#{file}" "$HOME/.#{file}"}
end
