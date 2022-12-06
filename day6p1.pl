#!/usr/bin/perl
use warnings;
use strict;

sub is_unuq_string {
  my ($token) = @_;
  my $letter = substr($token, 0, 1);
  my $substr = substr($token, 1, 3); 
  if (index($substr, $letter) < 0) {
    $letter = substr($token, 1, 1);
    $substr = substr($token, 2, 2); 
    if (index($substr, $letter) < 0) {
        $letter = substr($token, 2, 1);
        $substr = substr($token, 3, 1);
        if ($substr ne $letter) {
            return 1;
        } 
    } 
  } 
  return 0;
}

my $filename = 'inputs/input_day6.txt';

open(FH, '<', $filename) or die $!;

my $text = <FH>;

for my $i (0..length($text)-5){
    my $token = substr($text, $i, 4);
    if (is_unuq_string($token) > 0) {
        my $result = $i + 4;
        print "$result\n";
        last; 
    }
}

close(FH);