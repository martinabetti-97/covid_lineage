# covid_lineage

## Steps

### STEP 1
Preliminary steps
```{bash}
cd /scratch/mbetti/covid-survey
mkdir survey-210901 (to be changed)
bash create_samplesheet.sh /path/to/fastq/files (to be changed)
```

### STEP 2
Run nf-core analysis

```{bash}
nextflow run nf-core/viralrecon --input sample_sheet.csv --outdir /scratch/mbetti/covid_survey/210901-survey --platform illumina --protocol amplicon --genome 'MN908947.3' --primer_set artic --primer_set_version 3  --skip_picard_metrics -r 2.2 -profile docker --skip_assembly --skip_kraken2 --skip_fastqc --skip_fastp
```
Nota : la pipeline di nf-core potrebbe tornare un errore se l'owner dei file è diverso dall'utente che lancia l'analisi
Problemi : controllo sul primer set (artic?) 

### STEP 3
Merging results

```{bash}
conda activate covid_seq
bash merge.sh survey-210901
```
Nota: file di interesse sono coverage.tsv e pangolin.csv
