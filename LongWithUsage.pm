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
 my $usage="Usage:\n\t".($descr->{'usage'}{'synopsis'} || $descr->{'synopsis'});
 my $flShowDefault=$descr->{'help'}{'show_default'} || $descr->{'show_default'};
 $flShowDefault=(defined $flShowDefault and $flShowDefault=~m/(?:true|yes|1)/i)?1:0;
 my $help=$usage;
 my (%hsh4gol,@UsageKeys,@UsageDesc);
 my @doUsageHelp=map { my $msg=$_; sub { my $ec=shift; print ${$msg}."\n"; exit($ec) if $ec; } } \$usage,\$help;
 push @{$descr->{'params'}},[['usage'],'',sub { print "$usage\n"; exit(0); },$descr->{'usage'}{'descr'} || 'Show brief usage info'], # 'Показать короткую справку о синтаксисе вызова'],
                            [['help'], '',sub { print "$help\n";  exit(0); },$descr->{'help'}{'descr'} || 'Show verbose help text']; # 'Показать полную справку о ключах и параметрах программы'];
 foreach my $opt (@{$descr->{'params'}}) {
  push @UsageKeys,join (' ',map { length($_)==1?'-'.$_:'--'.$_ } @{$opt->[0]});  
  my ($o2,$r2)=($opt->[2],ref $opt->[2]);
  push @UsageDesc,$opt->[3].(
   ($flShowDefault and defined $o2 and 
    ($r2 eq 'ARRAY' and @$o2 or $r2 eq 'SCALAR' and $$o2)
   )?' ['.($r2 eq 'ARRAY'?join(', ',map {'"'.$_.'"'} @$o2):'"'.$$o2.'"').']'
    :''                      );
  $hsh4gol{join('|',@{$opt->[0]}).$opt->[1]}=$opt->[2];
 }
 @UsageKeys=align('left',@UsageKeys);
 @UsageDesc=align('left',@UsageDesc); 
 $help.=join("\n\t  ",'',map { $UsageKeys[$_]."\t".$UsageDesc[$_] } 0..$#UsageKeys);
 GetOptions(%hsh4gol);
 map { my $msg=$_; sub { my $ec=shift; print ${$msg}."\n"; exit($ec) if $ec; } } \$usage,\$help;
 return map { my $msg=$_; sub { my $ec=shift; print STDERR ${$msg}."\n"; exit($ec) if $ec; } } \$usage,\$help;
}

1;
