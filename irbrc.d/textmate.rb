# included by .irbrc
# gotten from someone on dotfiles

# Textmate helper
def mate *args
  flattened_args = args.map {|arg| "\"#{arg.to_s}\""}.join ' '
  `mate #{flattened_args}`
  nil
end
