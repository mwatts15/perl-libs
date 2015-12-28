package Dmenu;
# author: Mark Watts <mark.watts@utexas.edu>
# date: Mon Dec 28 08:52:40 CST 2015

use strict;
use warnings;
use Exporter;
our @ISA = qw/Exporter/;
our @EXPORT_OK = qw /show_menu/;
our @EXPORT = qw /show_menu/;

# XXX: Can we declare module deps??
use IPC::Open2;

sub show_menu
{
    # TODO: Error handling
    my $menu_cmd = shift;
    my @ents = @_;
    my ($out, $in);
    my $pid = open2($out, $in, $menu_cmd);
    for my $x (@ents) {
        print $in $x . "\n";
    }
    close($in);
    waitpid($pid, 0);
    readline(*$out);
}

1;
