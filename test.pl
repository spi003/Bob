#!C:/Perl64/bin/perl

$SrcDataPath = "c:/customers/HP/library_delivery-4a/source_data";
$term_file = "$SrcDataPath/crimp_terminals.lst";
$series1 = "blank";
open (TERM, $term_file) || die "Terminal data file '$term_file' does not exist\n";
while(<TERM>)
{
   @line_array = split (/\t/);
   if ( ($line_array[0] ne $series1) && ($line_array[0] ne "Series") )
   {
   	$series = $line_array[0];
   	$series1 = $series;
   	$term_hash{$series} = $_;
   }
   else
   {
   	$term_hash{$series} .= $_;
   }		
}
close (TERM);

$SrchStrng = "5013340000";

foreach $term_series (sort keys(%term_hash) )
{
	@term_series_array = split (/\n/, $term_hash{$term_series});
	@search_results = grep /$SrchStrng/, @term_series_array;
	$cnt = @search_results;
	if ($cnt != 0)
	{
		print "Found one\n";
		push @found_array, @search_results;
	}
}

$FndCnt = @found_array;
print "[$FndCnt]\n";

for ($i=0; $i<$FndCnt ; $i++)
{
	@array_values = split (/\t/, $found_array[$i]);
	print "Found $array_values[2] in $array_values[0]\n";
}
