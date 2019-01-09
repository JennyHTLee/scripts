####exporting
export AUGUSTUS_CONFIG_PATH="/ceph/biotools/share/augustus-3.2.1/config/"
export GENEMARK_PATH="/homes/jlee/programs/gm_et_linux_64/gmes_petap"
export BAMTOOLS_PATH="/ceph/biotools/bin/"
export PATH=/ceph/biotools/share/augustus-3.2.1/bin:$PATH #contains augustus and bam2hints
export PATH=/ceph/biotools/share/augustus-3.2.1/scripts/:$PATH #script folder
export PATH="/homes/jlee/anaconda2/bin:$PATH"

####variables
GENOME="genome.fa.masked"
PROTEIN="Brassica_napus.annotation_v5.pep.fa"
GTH="/homes/jlee/programs/gth-1.7.0-Linux_x86_64-64bit/bin/gth"
PATH_BRAKER="/homes/jlee/anaconda2/bin/"
BAM="SRAread_vs_ref.bam.sorted"

####execute
$PATH_BRAKER/braker.pl --cores=16 --species=Bnapus_exp --genome=$GENOME --prot_seq=$PROTEIN --prg=gth --ALIGNMENT_TOOL_PATH=$GTH --gth2traingenes --trainFromGth --bam=$BAM
