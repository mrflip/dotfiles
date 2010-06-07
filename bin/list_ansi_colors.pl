#!/usr/bin/env perl

$bl="\e[0m\e[40m\e[37m"; 
for $r (0,) {
  for $g (0 .. 255/6) {
    for $b (0..5) { 
      $c = ($g*6) + $b ;
      printf "\e[38;5;${c}m%03d$bl  ", $c;
      print "\n" if ( ($c>=15) && (($c-15) % 6 == 0) || ($c==7)); 
    }
  }
}
print "\n";
