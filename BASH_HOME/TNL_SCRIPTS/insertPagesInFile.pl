#!/usr/local/bin/perl
#
#USAGE => insertPagesInFile.pl file_in file_out
#
# This program reads a file file_in,
# finds the line "end subroutine | end function | end module "
# insert in the next line ^CONTRL + L
#
$file_in  = shift(@ARGV);    # first argument is the name input file
$file_out = shift(@ARGV);    # output files

open( FILE_IN,  "<$file_in" )  || die "Can't open FILE_IN $file_in $!";
open( FILE_OUT, ">$file_out" ) || die "Can't create FILE_OUT $file_out $! ";

$skip_line = 'false';

while (<FILE_IN>) {
  $line = $_;
  chomp($line);
  print FILE_OUT $_;
  if ( $line
    =~ /^\s*end\s*subroutine\s*|^\s*end\s*program\s*|^\s*end\s*function\s*|^\s*end\s*module\s*|^\s*end\s*type\s*/i
    )
  {
    print
      "\nLine with end subroutine  \'$line\' is found in the file $file_in \n";
    ( $space, $subroutine, $current_name, $rest ) = split(/\s+/);
    print FILE_OUT "\n";
    print FILE_OUT "\n";     # Insert blank line on new page
  }
}
close(FILE_IN)  || die "Can't close FILE_IN $file_in $!";
close(FILE_OUT) || die "Can't close FILE_OUT $file_out $!";

