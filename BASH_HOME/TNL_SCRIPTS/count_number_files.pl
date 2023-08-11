#!/usr/bin/perl
# perl /tmp/dircount.pl /etc/ | sort -n | tail

my $indir=$ARGV[0];

if( ! "$indir" || $indir !~ m{^/} )
{
        print "Input must be a single absolute path.\n";
        exit 1;
}

sub dircount {
        my $dir = shift;
        # print "dir: $dir\n";
        my $count = 0;
        opendir( my $dirhandle, $dir );
        foreach my $file (readdir( $dirhandle )) {
                next if( $file =~ m{^..?$} );
                my $new = "$dir/$file";
                $new =~ s{/+}{/}g;
                $count += 1;
                if( -d $new && ! -l $new )
                {
                        $count += dircount( $new );
                }
        }
        print "$count $dir\n";
        return $count;
}

dircount($indir);

