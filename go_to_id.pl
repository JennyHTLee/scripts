#!usr/bin/perl
use warnings;
use strict;

################Author:JennyLee 
################Date: 04042018
################example input:
################AT1G66410.1	Dbxref="InterPro:IPR011992"
################AT1G66410.1	Dbxref="InterPro:IPR018247"
################example output:
################AT1G66410.1	Dbxref="InterPro:IPR011992";Dbxref="InterPro:IPR018247"
################Description: Script merges multiple lines with the same element in field 1. It works with any data, as long as the two columns are tab separated

open (IN1, "$ARGV[0]") or die $!;

my @raw_array = ();
my %hash = ();

@raw_array = <IN1>;
chomp @raw_array;

foreach (@raw_array){
	(my $id, my $go) = split(/\t/,$_);
	push (@{$hash{$id}}, $go);
}
#$"=", ";

$"=";";

while (my ($key, $value)=each %hash){
	print "$key\t@{$value}\n";
}
#@{$hash{$id}}\n";

__END__

#my @id_array = ();
#my @id_go_array = (); 
my @go_array = ();

@id_go_array = <IN1>;
chomp @id_go_array;
#print "@id_go_array\n";

foreach (@id_go_array) {
	chomp;
	(my $id, my $go) = split (/\t/, $_);
	push (@id_array, $id);
}
#print "@id_array\n";
my @uniq_id_array = &uniq(@id_array);
#print "@uniq_id_array\n";

foreach (@uniq_id_array){
	#print "$_\n";
	@matched_go_array = grep (/^$_/,@id_go_array);	 
	split	
}
	#print "@go_array";


















##subroutines##################
sub uniq {
	return keys %{{ map {$_ => 1} @_ }};
}

