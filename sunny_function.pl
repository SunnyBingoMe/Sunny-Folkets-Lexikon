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