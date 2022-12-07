#!/usr/bin/perl
use warnings;
use strict;

my $LENGTH_OF_TOKEN = 14;

sub is_unuq_string {
  my ($token) = @_;

  for my $i (0..$LENGTH_OF_TOKEN - 2){
    my $letter = substr($token, $i, 1);
    my $substr = substr($token, $i+1, $LENGTH_OF_TOKEN-($i+1)); 
    if (index($substr, $letter) >= 0) {
      return 0;
    } 
  }

  my $letter_pl = substr($token, $LENGTH_OF_TOKEN - 2, 1);
  my $letter_l = substr($token, $LENGTH_OF_TOKEN - 1, 1);
  if ($letter_pl ne $letter_l) {
      return 1;
  } else {
    return 0;
  }
}

my $filename = 'inputs/input_day6.txt';

open(FH, '<', $filename) or die $!;

my $text = <FH>;

for my $i (0..length($text)-$LENGTH_OF_TOKEN-1){
    my $token = substr($text, $i, $LENGTH_OF_TOKEN);
    if (is_unuq_string($token) > 0) {
        my $result = $i + $LENGTH_OF_TOKEN;
        print "$result\n";
        last; 
    }
}

close(FH);