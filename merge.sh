out=$1

echo 'sample,taxon,lineage,conflict,ambiguity_score,scorpio_call,scorpio_support,scorpio_conflict,version,pangolin_version,pangoLEARN_version,pango_version,status,note' > pangolin.csv
for i in $survey/variants/ivar/pangolin/*pangolin.csv;
do line=$(head -n 2 $i | tail -1); s=$(sed 's/,.*//' <<< $line) ; sample_id=$(sed 's/Consensus_*//' <<< $s |  sed 's/.consensus.*//'); echo $sample_id','$line >> $survey/$1/pangolin.csv; done
