input=$PWD
out=$PWD
mem='8.GB'
cpu='16'
assembly=''

while getopts iomcha option
do case "${option}" in
i) input="${OPTARG}" ;;
o) out="${OPTARG}" ;;
m) mem="${OPTARG}" ;;
c) cpu="${OPTARG}" ;;
a) assembly="${OPTARG}" ;;
h)	echo "Usage:"
	echo "		-h	Display this help message."
	echo "		-i 	Input full path (default PWD)."		 
	echo "		-o	Output full path (default PWD)."  
	echo "		-m	Max memory (default 200.GB). 	NOT WORKING"
	echo "		-a 	Skip assembly [--skip_assembly] (default None)."  
	echo "		-c	Full path to reference genome (default 20)."  
	exit 0
	;;
esac
done

bash /mnt/nas/workflows/nfcore-utilities/viral/create_samplesheet.sh $input

nextflow run nf-core/viralrecon --input $input/sample_sheet.csv --outdir $out --platform illumina --protocol amplicon --genome 'MN908947.3' --primer_set artic --primer_set_version 4 $assembly --skip_picard_metrics -r 2.2 -profile docker  --skip_kraken2 --skip_fastqc --skip_fastp  --skip_picard_metrics  --skip_multiqc --skip_nextclade --max_memory 8.GB --max_cpus $cpu -c /mnt/nas/workflows/nfcore-utilities/viral/costum.config

bash /mnt/nas/workflows/nfcore-utilities/viral/coverage.sh $out
bash /mnt/nas/workflows/nfcore-utilities/viral/merge.sh $out
python3 /mnt/nas/workflows/nfcore-utilities/viral/heatmap.py $out/variants/bowtie2/mosdepth/amplicon/all_samples.mosdepth.heatmap.tsv

exit 1
