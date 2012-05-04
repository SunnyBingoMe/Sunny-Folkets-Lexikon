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


$fileName = "tmp";
$fileNameRaw = "Sunny-Folkets-Lexikon-sv_en-BinSun.txt";
#$fileName = "dict-example.xml";
#$fileNameRaw = "dict-example-solved.xml";
open (FID, $fileName) or die("ERR open file: $fileName \n");
open (raw, ">$fileNameRaw") or die("ERR open file: $fileNameRaw \n");

## don't buffer output
my $old_fh = select socketSession;
$| = 1;
select $old_fh;

$lineNumber = 0;
$tCounterIncase = 0;
while(<FID>)
{
	$lineNumber ++;
	while (
		$_ =~ m/(lta href=)/ || #<a>href
		$_ =~ m/lt\/a>/ ||  #</a>
		$_ =~ m/(ltimg src)/ || #img
		$_ =~ m/(ltugt)/ || #<u>
		$_ =~ m/(lt\/ugt)/ ||
		$_ =~ m/(ltbgt)/ || #<b>
		$_ =~ m/(lt\/bgt)/ ||
		$_ =~ m/(ltigt)/ || #<i>
		$_ =~ m/(lt\/igt)/ ||
		$_ =~ m/(ltfont color="([^"]*)"gt)/ || #<font color ...
		$_ =~ m/(lt\/fontgt)/ ||

		$_ =~ m/(ltbr\/gt)/ ||
		$_ =~ m/(lt\/gt)/ 
	) {
		$tFoundEntity = $1;
		debugOk "found entity:'$tFoundEntity' at line $lineNumber.";
		$tCounterIncase ++;
		if ($tCounterIncase > 50){
			say "ERR: line: $lineNumber:$_, entity: $tFoundEntity.";
			exit 1;
		}
		$_ =~ s/lta href=/<a href=/; #<a>href
		$_ =~ s/lt\/a>/<\/a>/; #</a>
		$_ =~ s/ltimg src/<img src/; #img
		$_ =~ s/ltugt/<u>/; #<u>
		$_ =~ s/lt\/ugt/<\/u>/;
		$_ =~ s/ltbgt/<b>/; #<b>
		$_ =~ s/lt\/bgt/<\/b>/;
		$_ =~ s/ltigt/<i>/; #<i>
		$_ =~ s/lt\/igt/<\/i>/;
		$_ =~ s/ltfont color="([^"]*)"gt/<font color="$1">/; #<font color ...
		$_ =~ s/lt\/fontgt/<\/font>/;

		$_ =~ s/ltbr\/gt/<br\/>/;
		$_ =~ s/lt\/gt/<\/>/;
	}
	$tCounterIncase = 0;
	if ( !($_ =~ /^$/) ) {
		print raw $_;
	}
}

print raw '0
@@@LINK=sunny
</>
sunny 
	Sunny Folkets Lexikon  <br/>
	sv-en/sv (for mdict)  <br/>
	v1.0.2012-05-04.1340 <br/> <br/>
	http://bit.ly/sunny-lexikon <br/>
	BinSun@mail.com <br/>
</>
sunnyboy
@@@LINK=sunny
</>
BinSun
@@@LINK=sunny
</>
SunBin
@@@LINK=sunny
</>';

close (FID);
close (raw);
#system ("dos2unix $fileNameRaw");
exit;

