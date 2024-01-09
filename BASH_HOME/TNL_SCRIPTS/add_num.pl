#!/usr/bin/perl -w
#
# SCRIPT: add_num.pl
# AUTHOR: Nick Tausnev, ntausnev@giss.nasa.gov
# DATE:   DATE_of_CREATION 10/19/2008
# REV:    1.1.A (Valid are A, B, D, T and P)
#               (For Alpha, Beta, Dev, Test and Production)
#
# PLATFORM: (SPECIFY: AIX, HP-UX, Linux, Solaris
#                      or Not platform dependent)
#
# PURPOSE: Give a clear, and if necessary, long, description of the
#          purpose of the shell script. This will also help you stay
#          focused on the task at hand.
#
# REV LIST:
#        DATE: DATE_of_CREATION 10/19/2008  DATE_of_REVISION
#        BY:	  AUTHOR_of_MODIFICATION
#        MODIFICATION: Describe what was modified, new features, etc-
#
#
# set -n   # Uncomment to check your syntax, without execution.
#          # NOTE: Do not forget to put the comment back in or
#          #       the shell script will not execute!
# set -x   # Uncomment to debug this shell script (Korn shell only)
#
use warnings;
use strict;
##########################################################
########### DEFINE FILES AND VARIABLES HERE ##############
##########################################################

# Empty (blank) line
my $blank80
  ="                                                                                ";
##########################################################
############### DEFINE FUNCTIONS HERE ####################
##########################################################
sub help {
  print <<EndHelp;
Usage: $0 [options] [files]
Options:
 -a 

Files: Multiple files are accepted.

EndHelp
  exit(1);
}
##########################################################
################ BEGINNING OF MAIN #######################
##########################################################

my $length;
my $frequency = 10;
my $filename  = $ARGV[0];
open( INFILE, "< $filename" ) or die "Can't open $filename for reading: $!\n";
while (<INFILE>) {
  my $line = $_;
  my $num  = $.;
  my $rest = $num % $frequency;
  $length = length($line);

  if ( ( $rest == 0 ) && ( $length < 60 ) ) {
    chomp($line);

    # print "line num=$. length=$length\n";
    $line = $line . $blank80;

    substr( $line, 73, 4 ) = "L " . $.;
    my $c80 = substr( $line, 0, 80 );
    $line = $c80 . "\n";
  }
  print "$line";
  #   last if $. == $line_number;
}

# End of script
exit(0);

