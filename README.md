# covid_lineage

## Steps

### STEP 1
Merge from basemount. Se i samples sono su una single lane funziona ugualmente.
```{bash}

cd /basemount/mount/dir/Project/Samples 
/bin/bash /data/workflows/meta/merge_nextseq_files_parcat.sh /scratch/mbetti/test/
```
Samplesheet generation

```{bash}
cd /scratch/mbetti/covid-survey
mkdir survey-210901 (to be changed)
bash create_samplesheet.sh /absolute/path/to/fastq/files (to be changed)
```

### STEP 2
Run nf-core analysis

```{bash}
Covid_survey.sh
```
- La pipeline di nf-core potrebbe tornare un errore se l'owner dei file è diverso dall'utente che lancia l'analisi, oppure se i file si trovano in una cartellla di cui non si è owner.
- Il comando assume che si lanci il comando nella stessa directory dove si trova il samplesheet e non genera una subfolder per l'output.
- Max-memory è settato a 200 GB.
- La versione di pangolin è aggiornata attraverso il file di configurazione.

Problemi : controllo sul primer set (artic?) 

### STEP 3
#### Generare i BED a partire dai BAM 

```{bash}
conda activate covid-survey
bash make_bed.sh 
```
Nota: da girare direttamente nella directory PWD/variants/bowtie/

```{bash}
conda activate covid-survey
bash make_bed.sh 
```

Nota: da girare dove sono i bed per generare il file summary sul coverage

#### Merge dei risultati di lineage

```{bash}
bash merge.sh survey-210901
```
Nota: file di interesse sono coverage.tsv e pangolin.csv
