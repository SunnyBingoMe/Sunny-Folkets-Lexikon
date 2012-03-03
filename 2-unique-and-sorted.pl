#!/usr/bin/perl
use List::MoreUtils qw(uniq);
### debug variables
#beta:
$sayOk = 1;
$debug = 1;
$dDebug = 0;
$debugOk = 0;
$dDebugOk = 0;
## end debug variables

sub say
{
	for (my $i = 0; $i <= $#_; $i++)
	{
		print "$_[$i]\n";
	}
}
sub sayOk
{
	if($sayOk)
	{
		say @_;
	}
}
sub debug
{
	if($debug)
	{
		say @_;
	}
}
sub dDebug
{
	if($dDebug)
	{
		say @_;
	}
}
sub debugOk
{
	if($debugOk)
	{
		say @_;
	}
}
sub dDebugOk
{
	if($dDebugOk)
	{
		say @_;
	}
}
sub nl
{
	say "";
}

sub mean
{
	my $sum = sum(@_);
	debug "sum in mean(): $sum.\n";
	$mean__GS = $sum/($#_+1);
	return $mean__GS;
}

$filenameFrom = "folkets_sv_en_public_soundFile_2012-02-26-0013_fixed-several-encoding-err-in-beginning.txt";
open (fFrom, $filenameFrom) or die("ERR open file: $filenameFrom \n");
$filenameTo = "folkets_sv_en_public_soundFile_2012-02-26-0030_unique-sorted.txt";
open (fTo, ">$filenameTo") or die("ERR open file: $filenameTo \n");

## don't buffer output
my $old_fh = select socketSession;
$| = 1;
select $old_fh;

$lineNumber = 0;
@lines = <fFrom>;
@lines = sort @lines;
@lines = uniq @lines;

print fTo @lines;


close (fFrom);
close (fTo);
exit;
