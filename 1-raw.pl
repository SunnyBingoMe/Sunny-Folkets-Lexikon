#!/usr/bin/perl
use List::Util qw(sum);
use Socket;
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


# $serverPort = 1579;
# $serverIp = "127.0.0.1";
# $serverIp = "194.47.148.200";
# socket( socketSession, PF_INET, SOCK_STREAM, getprotobyname('tcp') );
# connect( socketSession, sockaddr_in($serverPort, inet_aton($serverIp)) );
$fileName = "folkets_sv_en_public.xml";
$fileNameRaw = "folkets_sv_en_public_soundFile-list-raw.txt";
open (FID, $fileName) or die("ERR open file: $fileName \n");
open (raw, ">>$fileNameRaw") or die("ERR open file: $fileName \n");

## don't buffer output
my $old_fh = select socketSession;
$| = 1;
select $old_fh;

# print socketSession "bisu10\n";

$lineNumber = 0;
while(<FID>)
{
    debugOk "ok: $_";
	$lineNumber ++;
	if( $_ =~ /soundFile="(.*\.swf)"/ ){
		# debug "found $1 at $lineNumber.";
		print raw "$1\n";
	}
}

# @value1List = sort  @value1List;

# close socketSession;
close (FID);
close (raw);
exit;