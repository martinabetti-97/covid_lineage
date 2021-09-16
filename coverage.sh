for bam in *.ivar_trim.sorted.bam; do echo $bam; bamtocov $bam >  "${bam%%.*}".bed; done

for f in *.bed; do
  	base=$(basename $f)
  	echo $f
	tmp='/scratch/mbetti/covid-survey/210902-survey/variants/bowtie2/bed'
	grep MN908947 $f | awk '{ if ($2 >= 21563 && $2 <= 25384) print }' > ${base%%.*}_spike_coverage.bed
	grep MN908947 $f | awk '{ if ($2 >= 22517 && $2 <= 23185) print }' > ${base%%.*}_rbd_coverage.bed
  echo -e "${base%%.*}\t$(datamash median 4 < ${base%%.*}_spike_coverage.bed)\t$(sort -n -k4 ${base%%.*}_spike_coverage.bed | head -1 | cut -
f 4)\t$(sort -n -k4 ${base%%.*}_spike_coverage.bed | tail -1 | cut -f 4)\t$(datamash median 4 < ${base%%.*}_rbd_coverage.bed)\t$(sort -n -k4 
${base%%.*}_rbd_coverage.bed | head -1 | cut -f 4)\t$(sort -n -k4 ${base%%.*}_rbd_coverage.bed | tail -1 | cut -f 4)" >> coverage.tsv
  #-------coverage locus VoCs
  #bedtools intersect -a $f -b /data/sequence/covid-19/covid-seq/voc.bed -nonamecheck > $coverageDir/${base%%.*}_coverage_vocs.tsv
done
