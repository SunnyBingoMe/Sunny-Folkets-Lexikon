#!/usr/bin/perl
# ARGV[0] is starting line number; while [1] is ending.

use LWP::Simple;

###########################  Author : BinSun@mail.com ##############################
$sayOk = 0; $debug = 1; $dDebug = 1; $debugOk = 0; $dDebugOk = 0;
sub say		{foreach (@_){print "$_\n";}}	sub nl{say "";}
sub sayOk	{if($sayOk){say @_;}}			sub endl{print "\n";}
sub debug	{if($debug){say @_;}}			sub debugOk	{if($debugOk){say @_;}}
sub dDebug	{if($dDebug){say @_;}}			sub dDebugOk{if($dDebugOk){say @_;}}
####################################################################################

# Perl trim function to remove whitespace from the start and end of the string
sub trim($){
	my $string = shift;
	$string =~ s/^\s+//;
	$string =~ s/\s+$//;
	return $string;
}
# Left trim function to remove leading whitespace
sub ltrim($){
	my $string = shift;
	$string =~ s/^\s+//;
	return $string;
}
# Right trim function to remove trailing whitespace
sub rtrim($){
	my $string = shift;
	$string =~ s/\s+$//;
	return $string;
}

if ($#ARGV != 1){
	say "two parameters are needed";
	exit (1);
}

$startLine = $ARGV[0];
$endLine = $ARGV[1];
say "startLine=$startLine";
say "endLine=$endLine";

$filenameFrom = "folkets_sv_en_public_soundFile_2012-02-26-0036_url-filename.txt";
$filenameTo = "folkets_sv_en_public_soundFile_2012-02-26-0213_err-log.txt";
open (fFrom, $filenameFrom) or die("ERR open file: $filenameFrom \n");
open (fTo, ">>$filenameTo") or die("ERR open file: $filenameTo \n");

## don't buffer output
my $old_fh = select socketSession;
$| = 1;
select $old_fh;

$lineNumber = 0;
while(<fFrom>){
	$lineNumber ++;
	if ($lineNumber >= $endLine){
		debugOk "break";
		break;
	}
	elsif ($lineNumber >= $startLine){
		$filename = rtrim($_);
		debug "downloading $lineNumber: $filename";
		$url = "http://lexin.nada.kth.se/sound/$filename";
		if ( getstore($url, "lexin/$filename") ){
			print fTo "$filename\n"; # create this folder before download
		}
	}
}

close (fFrom);
close (fTo);
exit;
