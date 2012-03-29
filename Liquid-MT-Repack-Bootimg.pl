#!/usr/bin/perl -W

use strict;
use Cwd;


my $dir = getcwd;

my $usage = "Liquid-MT-Repack-Bootimg.pl <kernel> <ramdisk-directory> <outfile>\n";

die $usage unless $ARGV[0] && $ARGV[1] && $ARGV[2];

chdir $ARGV[1] or die "$ARGV[1] $!";

system ("find . | cpio -o -H newc | gzip > $dir/ramdisk-repack.cpio.gz");

chdir $dir or die "$ARGV[1] $!";

system ("~/Acer/Liquid-MT/Tools/Liquid-MT-mkbootimg --kernel $ARGV[0] --ramdisk ramdisk-repack.cpio.gz --cmdline console=null -o $ARGV[2]");

unlink("ramdisk-repack.cpio.gz") or die $!;

print "\nrepacked boot image to $ARGV[2]\n";
