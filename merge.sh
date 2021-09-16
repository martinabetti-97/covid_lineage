#/bin/bash
#pass output dir of nf-core a parameter
#find results in final inside output dir

survey=$PWD/$1
echo 'sample,taxon,lineage,conflict,ambiguity_score,scorpio_call,scorpio_support,scorpio_conflict,version,pangolin_version,pangoLEARN_versio>
for i in $survey/variants/ivar/pangolin/*pangolin.csv;
do line=$(head -n 2 $i | tail -1); s=$(sed 's/,.*//' <<< $line) ; sample_id=$(sed 's/Consensus_*//' <<< $s |  sed 's/.consensus.*//'); echo >

mkdir final 
mv *coverage* final
mv samples.txt final
mv pangolin.csv final
mv -r final $survey
