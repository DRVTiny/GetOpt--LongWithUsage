#!/usr/bin/perl
package Getopt::LongWithUsage;
use utf8;
use strict;
use warnings;
use Text::Aligner qw(align);
use Getopt::Long qw(GetOptions);;

use Exporter qw(import);
our @EXPORT_OK=qw(GetOptsAndUsage);

sub GetOptsAndUsage {
 my $descr=shift;
 my $usage="Usage:\n\t".$descr->{'synopsis'}."\n";
 my (%hsh4gol,@UsageKeys,@UsageDesc);
 push @{$descr->{'params'}},[['usage'],'',sub { print "$usage"; exit(0); },'Показать ровным счётом то, что вы видите сейчас'];
 foreach my $opt (@{$descr->{'params'}}) {
  push @UsageKeys,join (' ',map { length($_)==1?'-'.$_:'--'.$_ } @{$opt->[0]});
  push @UsageDesc,$opt->[3];
  $hsh4gol{join('|',@{$opt->[0]}).$opt->[1]}=$opt->[2];
 }
 @UsageKeys=align('left',@UsageKeys);
 @UsageDesc=align('left',@UsageDesc);
 for (my $i=0; $i<scalar(@UsageKeys); $i++) {
  $usage.=$UsageKeys[$i]."\t".$UsageDesc[$i]."\n";
 }
 GetOptions(%hsh4gol);
 return 1;
}

1;
