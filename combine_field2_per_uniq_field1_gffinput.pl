#!usr/bin/perl
use warnings;
use strict;

##29032016 Jenny Lee 
##script takes interproscan gff output and create unique lines of protein id"\t"GOid

open (IN1, "$ARGV[0]") or die $!;

my @in ="";
my @info ="";
my @goarray ="";
my @gos ="";
my @oldgos = "";
my @currentgos = "";
my $id ="";
my $oldid =0;

############################example input
##gff-version 3
##feature-ontology http://song.cvs.sourceforge.net/viewvc/song/ontology/sofa.obo?revision=1.269
##interproscan-version 5.33-72.0
##sequence-region g124354.t1 1 768
#g124354.t1	.	polypeptide	1	768	.	+	.	ID=g124354.t1;md5=ae022f20523321cad2297037653c7e83
#g124354.t1	Pfam	protein_match	18	145	8.0E-10	+	.	date=04-10-2019;Target=g124354.t1 18 145;ID=match$1_18_145;signature_desc=Universal stress protein family;Name=PF00582;status=T;Dbxref="InterPro:IPR006016"
#g124354.t1	ProSiteProfiles	protein_match	449	711	35.679	+	.	date=04-10-2019;Target=g124354.t1 449 711;Ontology_term="GO:0004672","GO:0005524","GO:0006468";ID=match$2_449_711;signature_desc=Protein kinase domain profile.;Name=PS50011;status=T;Dbxref="InterPro:IPR000719"
#g124354.t1	ProSitePatterns	protein_match	567	579	.	+	.	date=04-10-2019;Target=g124354.t1 567 579;Ontology_term="GO:0004672","GO:0006468";ID=match$3_567_579;signature_desc=Serine/Threonine protein kinases active-site signature.;Name=PS00108;status=T;Dbxref="InterPro:IPR008271"
#g124354.t1	PANTHER	protein_match	5	743	0.0	+	.	date=04-10-2019;Target=g124354.t1 5 743;ID=match$4_5_743;Name=PTHR27003:SF252;status=T
#g124354.t1	Pfam	protein_match	452	703	2.9E-39	+	.	date=04-10-2019;Target=g124354.t1 452 703;Ontology_term="GO:0004672","GO:0006468";ID=match$5_452_703;signature_desc=Protein tyrosine kinase;Name=PF07714;status=T;Dbxref="InterPro:IPR001245"
#############################example output
#g124354.t1	GO:0004672 GO:0006468 GO:0005524
#g68770.t1	GO:0005515
#g6605.t1	GO:0005515
#g112680.t3	GO:0005515 GO:0003774 GO:0005524 GO:0016459
#g153289.t1	GO:0005515
#g100739.t1	GO:0008270


while (<IN1>){
	chomp;
	if ($_ =~ /protein_match/){
		@in = split ("\t", $_);
		@info = split (";" , $in[8]);
		foreach my $x (@info) {
			if ($x =~ /Ontology_term=/){	
				my $id = $in[0];
				$x =~ s/"//g;
				@goarray = split ("=" , $x);
				@gos = split ("," , $goarray[1]);
				if ($id eq $oldid ) {
					@currentgos = (@gos , @oldgos);
#					print "@currentgos\n";
					@currentgos = uniq(@currentgos);
#					print "$id\t$oldid\t@currentgos\n";
				} elsif ($oldid eq 0) {
					@currentgos = @gos;
				} elsif ($id ne $oldid){
					@currentgos = @gos;
					print "$oldid\t@oldgos\n";
#					print "$id\t$oldid\t@currentgos\n";
				}
		        $oldid = $id;
			@oldgos = @currentgos;
#			print "$oldid\n";
			} else {next;}	
		}
	}
}		
	print "$oldid\t@oldgos\n";

	

sub uniq {
    my %seen;
    grep !$seen{$_}++, @_;
}


__END__

