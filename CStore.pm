package CStore;
# author: Mark Watts <watts.mark2015@utexas.edu>
# date: Mon Dec 28 08:13:47 CST 2015

use strict;
use warnings;
use Exporter;
our @ISA = qw/Exporter/;
our @EXPORT_OK = qw /sanitize_value desanitize_value/;
our @EXPORT = qw /sanitize sanitize_value parse/;


sub sanitize_value
{
    my $data = $_[0];
    # The `#' has to come first so it doesn't get replaced twice in the string
    my @badchars = ("#", ":", " ");
    for my $ch (@badchars)
    {
        my $ch_num = ord($ch);
        $data =~ s/$ch/"#" . sprintf("%05d", $ch_num)/eg;
    }
    $data;
}

sub desanitize_value
{
    my $data = $_[0]; 
    $data =~ s/#([0-9]{5})/chr($1)/eg;
    $data;
}

sub parse
{
    my $F = shift;
    my %res = ();
    seek $F, 0, 0;
    while (!eof($F))
    {
        chomp(my $line = readline $F);
        my ($pname, $rest) = split /:/, $line, 2;
        my (%pinfo) = split /:/, $rest;
        $res{$pname} = ();
        for my $key (keys %pinfo)
        {
            $res{$pname}{$key} = $pinfo{$key};
        }
    }
    \%res;
}

1;
