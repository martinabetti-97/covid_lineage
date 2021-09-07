survey=$1
echo 'sample,fastq_1,fastq_2' > $survey/sample_sheet.csv
for fname in $survey/*1.fastq.gz
do
    sample=${fname%_*}
    sample_id=$(basename $sample)
    if [ -f $sample'_R1.fastq.gz' ]; then 
	echo $sample_id','$sample'_R1.fastq.gz,'$sample'_R2.fastq.gz' >> $survey/sample_sheet.csv
    fi
    if [ -f $sample'_1.fastq.gz' ]; then 
	echo $sample_id','$sample'_1.fastq.gz,'$sample'_2.fastq.gz' >> $survey/sample_sheet.csv
    fi
done
