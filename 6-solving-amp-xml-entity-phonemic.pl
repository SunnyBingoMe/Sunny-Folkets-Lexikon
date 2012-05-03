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

	sub say {
		for (my $i = 0; $i <= $#_; $i++)
		{
			print "$_[$i]\n";
		}
	}
	sub sayOk {
		if($sayOk)
		{
			say @_;
		}
	}
	sub debug {
		if($debug)
		{
			say @_;
		}
	}
	sub dDebug {
		if($dDebug)
		{
			say @_;
		}
	}
	sub debugOk {
		if($debugOk)
		{
			say @_;
		}
	}
	sub dDebugOk {
		if($dDebugOk)
		{
			say @_;
		}
	}
	sub nl {
		say "";
	}

	sub mean {
		my $sum = sum(@_);
		debug "sum in mean(): $sum.\n";
		$mean__GS = $sum/($#_+1);
		return $mean__GS;
	}


$fileName = "folkets_sv_en_public_2012-02-26.xml";
$fileNameRaw = "folkets_sv_en_public_2012-02-26_solved-amp.xml";
#$fileName = "dict-example.xml";
#$fileNameRaw = "dict-example-solved.xml";
open (FID, $fileName) or die("ERR open file: $fileName \n");
open (raw, ">$fileNameRaw") or die("ERR open file: $fileName \n");

## don't buffer output
my $old_fh = select socketSession;
$| = 1;
select $old_fh;

$lineNumber = 0;
@inflectionList = ();
while(<FID>)
{
	debugOk "ok: $_";
	chomp ($_);
	$lineNumber ++;

	if ($_ =~ m/<word[^>]+value="([^"]+)"/){
		$tWord = $1;
	}
	if ($_ =~ m/<word[^>]+class="([^"]+)"/){
		debugOk "class: $tClass.";
		$tClass= $1;
	}
	$tCounterInCaseNewBug = 0;
	#$tCounterInCaseNewPhonemic = 0;
	$tCounterInCaseNewStrong = 0;
	while ($_ =~ m/&amp;\S{1,5};/){
		$tCounterInCaseNewBug ++;
		if ($tCounterInCaseNewBug >= 100){
			say ("ERR: found new &amp;xxx;:$_ at line: $lineNumber.");
			exit 1;
		}
		$_ =~ s/&amp;quot;/&quot;/;
		$_ =~ s/&amp;#39;/&#39;/;
	}
	$tCounterInCaseNewBug = 0;
	if ($_ =~ m/^(.*<phonetic.*value=")([^"]+)(".*)$/) { #handle phonemic
		$tBeforePhonemic = $1;
		$tPhonemic = $2;
		$tAfterPhonemic = $3;
		debugOk "before change: $tBeforePhonemic$tPhonemic$tAfterPhonemic. (line: $lineNumber)";
		debugOk "tPhonemic: $tPhonemic.";
		#while ($tPhonemic =~ m/[^²\wåÅäÄöÖàéê :;,\-\.\(\)]+/){ #$,@,+, etc. but dealing with grave accent later.
			#$phonemicToBeChanged = $tPhonemic;
			#debugOk "found phonemicToBeChanged:'$phonemicToBeChanged' at line $lineNumber:$_";
			#$tCounterInCaseNewPhonemic ++;
			#if ($tCounterInCaseNewPhonemic >= 10){
				#say ("ERR: found new phonemic: '$phonemicToBeChanged' in '$_' at line: $lineNumber.");
				#exit 1;
			#}
			#$tPhonemic =~ s/2/²/; # \w contains numbers.
			#$tPhonemic =~ s/\+/‿/;
			#$tPhonemic =~ s/@/ŋ/;
			#$tPhonemic =~ s/\$/ʃ/;
			#$tPhonemic =~ s/c/ç/;
		#}
		for ($tReverseCounterForNonAlphabatPhonemic = 3; $tReverseCounterForNonAlphabatPhonemic > 0; $tReverseCounterForNonAlphabatPhonemic --){
			$tPhonemic =~ s/2/²/;
			$tPhonemic =~ s/\+/‿/;
			$tPhonemic =~ s/@/ŋ/;
			$tPhonemic =~ s/\$/ʃ/;
			$tPhonemic =~ s/c/ç/;
		}
		#$tCounterInCaseNewPhonemic = 0;
		$tPhonemic =~ s/el\. /，/;
		$tCounterInCaseNewStrong = 0;
		while ($tPhonemic =~ m/^(.*)([A-Z]{1})(.*)$/) {
			$tBeforeStrong = $1;
			$tStrong = $2;
			$tAfterStrong = $3;
			debugOk "found strong: $tStrong in phonemic: $tPhonemic at line: $lineNumber.";
			$tCounterInCaseNewStrong ++;
			if ($tCounterInCaseNewStrong >= 10){
				say ("ERR: found new strong: '$tStrong' at line: $lineNumber.");
				exit 1;
			}
			$tStrong =~ tr/[A-Z]/[a-z]/;
			$tStrong = "&#39;$tStrong";
			$tPhonemic = $tBeforeStrong.$tStrong.$tAfterStrong;
		}
		for ($tCounterSwedishStrong = 1; $tCounterSwedishStrong <= 5; $tCounterSwedishStrong ++){
			#seems perl cannot distinguish Swedish upper case with lower case in regular expression.
			$tPhonemic =~ s/Å/&#39;å/;
			$tPhonemic =~ s/Ä/&#39;ä/;
			$tPhonemic =~ s/Ö/&#39;ö/;
		}
		$tCounterInCaseNewStrong = 0;
		$_ = "$tBeforePhonemic$tPhonemic$tAfterPhonemic";
		debugOk "after  change: $_.";
	} #end handle phonemic
	if ($_ =~ m/<inflection[^>]+value="([^"]+)"/) {
		$tInflection = $1;
		debugOk "found inflection:'$tInflection' of '$tWord'.";
		if ($tInflection ne $tWord) {
		#if ( ($tInflection ne $tWord) && ($tClass ne "nn") ) {
			debugOk "added inflection:$tInflection.";
			push (@inflectionList, $tInflection);
		}
	}
	if ($_ =~ m/<compound[^>]+value="([^"]+)"/) {
		$tCompoundWithPipeSign = $1;
		$tCompound = $tCompoundWithPipeSign;
		#$tCompound =~ s/\|//;
		if ($tCompound ne $tWord) {
			push (@inflectionList, $tCompoundWithPipeSign);
		}
	}
	#$_ =~ s/></>
	#</;
	print raw "$_\n";
	if ( ($_ =~ m/<\/word>/) && (@inflectionList != 0) ) {
		foreach (@inflectionList) {
			print raw '<word value="' . $_ . '" class="'. $tClass .'" sunnySoftRedirection="' . $tWord .'"'. ">\n</word>\n";
		}
		@inflectionList = ();
	}
}

close (FID);
close (raw);
system ("dos2unix $fileNameRaw");
exit;

