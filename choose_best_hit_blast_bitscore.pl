#!usr/bin/env perl
use warnings;
use strict;
use List::Util qw(reduce);

##11032019 Jenny Lee 
##script takes blast hit table, extract best hits using bitscore - output both if equal bitscore
##bitscore has to be in the 12th column

##example input
##BnaC04g00080.1D2	BnaC04g00090D	100.000	345	0	0	1	345	124	468	0.0	638	345	468
##BnaC04g00080.1D2	BnaA05g00200D	98.261	345	6	0	1	345	175	519	2.42e-172	604	345	519
##BnaC04g00080.1D2	BnaA03g21860D	91.667	348	20	4	1	345	130	471	7.12e-133	473	345	471
##BnaC04g00120.1D2	BnaC04g00140D	100.000	400	0	0	1	400	1	400	0.0	739	444	1785
##BnaC04g00120.1D2	BnaA05g00250D	95.250	400	19	0	1	400	1	400	0.0	634	444	1785
##BnaC04g00150.1D2	BnaC04g00160D	100.000	489	0	0	1	489	1	489	0.0	904	489	489
##BnaC04g00150.1D2	BnaA05g00280D	98.364	489	8	0	1	489	1	489	0.0	859	489	489

##example output
##BnaC04g00080.1D2	BnaC04g00090D	100.000	345	0	0	1	345	124	468	0.0	638	345	468
##BnaC04g00120.1D2	BnaC04g00140D	100.000	400	0	0	1	400	1	400	0.0	739	444	1785
##BnaC04g00150.1D2	BnaC04g00160D	100.000	489	0	0	1	489	1	489	0.0	904	489	489


open (IN1, "$ARGV[0]") or die $!;

my @in = ();
my @ids = ();
my @singleids = ();
my @dupids = ();
my @line_bit = ();
my %bit_of;
my @hit = ();
my %temp_hash = ();
my $hitsize = undef;
my @uniqids = ();
my $count;
my $maxbit;

while (<IN1>){
	chomp;
	@in = split ("\t", $_);
	push @ids, $in[0];
	push @line_bit, $_;
	push @line_bit, $in[11];
	}

@uniqids = uniq(@ids);


%bit_of=@line_bit;

foreach my $z (@uniqids){
		@hit = grep  /$z/, keys %bit_of;
		%temp_hash = map { $_ => $bit_of{$_} } @hit;
		#my $min = min values %temp_hash;
		my $max = List::Util::reduce {$temp_hash{$a} > $temp_hash{$b} ? $a : $b} keys %temp_hash;
		$maxbit = $temp_hash{$max};
		#print "$min\n";
		my @matches = grep { $temp_hash{$_} eq $maxbit} keys %temp_hash; #get key based on value
#		my ($toprint) = grep{ $temp_hash{$_} eq $mineval } keys %temp_hash;
#		foreach my $y (@matches) {
#			print "$y\n";
#		}
		print join("\n", @matches), "\n";
#		print "@matches\n";
#		my ($key) = grep{ $bugs{$_} eq '*value*' } keys %bugs;
#		print map { "$_\t$hash{$_}\n" } keys %temp_hash;
#		print "$temp_hash{$mineval}\n";
		#print "$temp_hash{ $min }\n";
		
		
}


sub uniq {
    my %seen;
    grep !$seen{$_}++, @_;
}

#sub single {
#     my %seen;
#     grep  ++$seen{$_} == 1, @_;
#}

#sub dups {
#   my %seen; 
#   grep ++$seen{$_} >= 2, @_;
#}

__END__

