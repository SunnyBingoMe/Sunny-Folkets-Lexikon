#!/usr/bin/perl
use List::Util qw(sum);
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


$fileName = "folkets_sv_en_public_2012-02-26.xml";
$fileNameRaw = "folkets_sv_en_public_2012-02-26_solved-amp.xml";
open (FID, $fileName) or die("ERR open file: $fileName \n");
open (raw, ">$fileNameRaw") or die("ERR open file: $fileName \n");

## don't buffer output
my $old_fh = select socketSession;
$| = 1;
select $old_fh;

$lineNumber = 0;
while(<FID>)
{
    debugOk "ok: $_";
	$lineNumber ++;
	$tCounterInCaseNewBug= 0;
	while ($_ =~ m/&amp;\S{1,5};/){
		$tCounterInCaseNewBug ++;
		if ($tCounterInCaseNewBug >= 100){
			die ("found new &amp;xxx;.");
		}
		$_ =~ s/&amp;quot;/&quot;/;
		$_ =~ s/&amp;#39;/&#39;/;
	}
	print raw "$_";
}

close (FID);
close (raw);
exit;
