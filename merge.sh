#bin/bash
survey=$PWD/$1
echo 'sample,taxon,lineage,conflict,ambiguity_score,scorpio_call,scorpio_support,scorpio_conflict,version,pangolin_version,pangoLEARN_version,pango_version,status,note' > pangolin.csv
for i in $survey/variants/ivar/pangolin/*pangolin.csv;
do line=$(head -n 2 $i | tail -1); s=$(sed 's/,.*//' <<< $line) ; sample_id=$(sed 's/Consensus_*//' <<< $s |  sed 's/.consensus.*//'); echo $sample_id','$line >> pangolin.csv; done

cp $survey'/variants/bowtie2/mosdepth/amplicon/all_samples.mosdepth.coverage.tsv' . 
cut -f4 --complement all_samples.mosdepth.coverage.tsv > all_samples.coverage.tsv

awk '{print $5}' all_samples.coverage.tsv | sort | uniq | grep -v "sample" > samples.txt
echo  "Sample	Spike_median_coverage	Spike_min_coverage	Spike_max_coverage	RBD_median_coverage	RBD_min_coverage	RBD_max_coverage" > coverage.tsv
while read -r f; do
grep $f all_samples.coverage.tsv | awk '{ if ($2 >= 21563 && $2 <= 25384) print }' > $f'_spike_coverage.bed'
grep $f all_samples.coverage.tsv | awk '{ if ($2 >= 22517 && $2 <= 23185) print }' > $f'_rbd_coverage.bed'
echo "$f	$(datamash median 4 < $f'_spike_coverage.bed')	$(sort -n -k4 $f'_spike_coverage.bed' | head -1 | cut -f 4)	$(sort -n -k4 $f'_spike_coverage.bed' | tail -1 | cut -f 4)	$(datamash median 4 < $f'_rbd_coverage.bed')	$(sort -n -k4 $f'_rbd_coverage.bed' | head -1 | cut -f 4)	$(sort -n -k4 $f'_rbd_coverage.bed' | tail -1 | cut -f 4)" >> coverage.tsv
bedtools intersect -a $survey"/variants/bowtie2/mosdepth/amplicon/${f}.mosdepth.coverage.tsv" -b voc.bed -nonamecheck > $f'_coverage_vocs.tsv'
done < samples.txt

mkdir final 
mv *coverage* final
mv samples.txt final
mv pangolin.csv final
mv *bed final

mv -r final $survey
