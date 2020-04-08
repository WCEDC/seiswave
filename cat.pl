#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(min);
use List::Util qw(max);
use Time::Local;

open (IN, "< abc.txt") or die;
my @out;
my $i = 0;
my $junk;
foreach my $info (<IN>) {
    $i++;
    chomp $info;
    ($info) = trim ($info);
    if ($i == 1) {
        $junk = $info;
    }else{
        $junk = "$junk $info";
    }
    push @out, $junk if ($i == 6);
    $i = 0 if ($i == 6);
}
foreach my $info (@out) {
    ($info) = del ($info);
    print "$info\n";
}

sub del {
    my $str = shift;
    my $i = 0;
    my $out;
    foreach (split //, $str) {
        next if ($_ eq "\n");
        $i = 1 if ($_ eq "<");
        $i = 0 if ($_ eq ">");
        next if ($i == 1);
        if (defined($out)) {
            $out = "$out$_" unless ($_ eq ">");
        }else {
            $out = $_ unless ($_ eq ">");
        }
    }
    return ($out);
}
sub trim { my $s = shift; $s =~ s/^\s+|\s+$//g; return $s };