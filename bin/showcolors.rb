#!/usr/bin/env ruby

# ANSI Color -- use these variables to easily have different color
#    and format output. Make sure to output the reset sequence after
#    colors (f = foreground, b = background), and use the 'off'
#    feature for anything you turn on.

module AnsiColors

  ESC =  ""

  # foreground
  BLKF = "#{ESC}[30m";   REDF = "#{ESC}[31m";  GRNF = "#{ESC}[32m"
  YLWF = "#{ESC}[33m";   BLUF = "#{ESC}[34m";  PURF = "#{ESC}[35m"
  CYAF = "#{ESC}[36m";   WHTF = "#{ESC}[37m"

  # background
  BLKB = "#{ESC}[40m";   REDB = "#{ESC}[41m";  GRNB = "#{ESC}[42m"
  YLWB = "#{ESC}[43m";   BLUB = "#{ESC}[44m";  PURB = "#{ESC}[45m"
  CYAB = "#{ESC}[46m";   WHTB = "#{ESC}[47m"

  # effects
  BLDY = "#{ESC}[1m";    BLD_ = "#{ESC}[22m"
  ITAY = "#{ESC}[3m";    ITA_ = "#{ESC}[23m"
  ULNY = "#{ESC}[4m";    ULN_ = "#{ESC}[24m"
  INVY = "#{ESC}[7m";    INV_ = "#{ESC}[27m"

  RESET = "#{ESC}[0m"
  
end

include AnsiColors

dumpstr = <<-EOF
    #{ULN_}#{BLD_}#{ITA_}#{RESET}
#{BLD_}#{CYAF}_________|_________2_________|_________4_________|_________6_________|_________8_________|_________0_________|_________2_________|_________4_________|_________6_________|_________8_________|_________0
#{BLD_}#{CYAF}123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789
#{BLDY}#{CYAF}_________|_________2_________|_________4_________|_________6_________|_________8_________|_________0_________|_________2_________|_________4_________|_________6_________|_________8_________|_________0
#{BLDY}#{CYAF}123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789
    #{ULN_}#{BLD_}#{ITA_}#{RESET}
#{BLDY}#{CYAF}_______._______._______._______._______._______._______._______._______._______._______._______._______._______._______._______._______._______._______._______
#{BLDY}#{CYAF}1234567 1234567 1234567 1234567 1234567 1234567 1234567 1234567 1234567 1234567 1234567 1234567 1234567 1234567 1234567 1234567 1234567 1234567 1234567 1234567
    #{ULN_}#{BLD_}#{ITA_}#{RESET}
#{ULNY}#{YLWF}Underlined:  	#{REDF}red       	#{GRNF}green   	#{BLDY}#{CYAF}cyan#{BLD_}#{ULN_}
#{ITAY}#{YLWF}Italics: 	#{REDF}red       	#{GRNF}green   	#{BLDY}#{CYAF}cyan#{BLD_}#{ITA_}
    #{ULN_}#{BLD_}#{ITA_}#{RESET}
#{BLD_}#{YLWF}Norm:   #{BLUF}blue    #{PURF}purple  #{CYAF}cyan    #{WHTF}white   #{CYAF}cyan    #{REDF}red     #{GRNF}green   #{BLKF}black
#{BLD_}#{YLWF}        #{BLKF}black   #{REDF}red     #{GRNF}green   #{YLWF}yellow  #{BLUF}blue    #{PURF}purple  #{CYAF}cyan    #{WHTF}white
#{BLDY}#{YLWF}Bold:   #{BLKF}black   #{REDF}red     #{GRNF}green   #{YLWF}yellow  #{BLUF}blue    #{PURF}purple  #{CYAF}cyan    #{WHTF}white
#{BLDY}#{YLWF}        #{BLUF}blue    #{PURF}purple  #{CYAF}cyan    #{WHTF}white   #{CYAF}cyan    #{REDF}red     #{GRNF}green   #{BLKF}black
    #{ULN_}#{BLD_}#{ITA_}#{RESET}
EOF

puts dumpstr
