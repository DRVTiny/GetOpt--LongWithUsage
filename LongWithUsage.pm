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
 my ($descr,$usageDsc,$helpDsc)=@_;
 my $usage="Usage:\n\t".($descr->{'usage'}{'synopsis'} || $descr->{'synopsis'});
 my $help=$usage."\n";
 my (%hsh4gol,@UsageKeys,@UsageDesc);
 my @doUsageHelp=map { my $msg=$_; sub { my $ec=shift; print ${$msg}."\n"; exit($ec) if $ec; } } \$usage,\$help;
 push @{$descr->{'params'}},[['usage'],'',sub { print "$usage\n"; exit(0); },$descr->{'usage'}{'descr'}], # 'Показать короткую справку о синтаксисе вызова'],
                            [['help'], '',sub { print "$help\n";  exit(0); },$descr->{'help'}{'descr'}]; # 'Показать полную справку о ключах и параметрах программы'];
 foreach my $opt (@{$descr->{'params'}}) {
  push @UsageKeys,join (' ',map { length($_)==1?'-'.$_:'--'.$_ } @{$opt->[0]});
  push @UsageDesc,$opt->[3];
  $hsh4gol{join('|',@{$opt->[0]}).$opt->[1]}=$opt->[2];
 }
 @UsageKeys=align('left',@UsageKeys);
 @UsageDesc=align('left',@UsageDesc); 
 $help.=join("\n",map { $UsageKeys[$_]."\t".$UsageDesc[$_] } 0..$#UsageKeys);
 GetOptions(%hsh4gol);
 map { my $msg=$_; sub { my $ec=shift; print ${$msg}."\n"; exit($ec) if $ec; } } \$usage,\$help;
 return map { my $msg=$_; sub { my $ec=shift; print STDERR ${$msg}."\n"; exit($ec) if $ec; } } \$usage,\$help;
}

1;
