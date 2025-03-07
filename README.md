# Salep ITS sequences detection Pipeline for ONT reads
This is the pipeline to classify reads of ITS sequences of a sample into taxonomic units and especially to detect ITS sequences of Salep (Orchid roots).
This pipeline incorporates these workflows/tools:
- epi2me-labs/wf-basecalling (https://github.com/epi2me-labs/wf-basecalling)
- dorado demux (https://github.com/nanoporetech/dorado)
- epi2me-labs/wf-metagenomics (https://github.com/epi2me-labs/wf-metagenomics)
(all accessed last March 7th 2025)

If there are questions, write me: Jeremy The (jthe@uni-bonn.de)

# Installation
1. clone this repository:
¸¸¸ bash
git clone https://github.com/jxlthe/salep_ITS_detection_pipeline
¸¸¸
2. fetch files from LFS: 
¸¸¸ bash
git lfs fetch --all
¸¸¸

# How to use

## Setup
Install conda and create the environment salep_ITS_detection_env with the environment.yaml file by executing the command "conda env create -f environment.yaml"

## Steps for each run
1. Have your .pod5 files ready in one folder (without subfolders).
2. Edit the configuration-file in cfg/config.yaml and provide the path to the pod5 folder as well as specifications for basecalling
2.1. The basecalling is done on the pod5 files, which is the output of the ONT sequencer and contain the singal data of the read. In general epi2me provides three types of Models to call the bases from these signals: fast, high accuracy (hac) and super accurate (sup) (See https://github.com/nanoporetech/dorado#available-basecallin-models for the full list of models). In the config.yaml you can choose the model as well as the minimum average quality score a read should have to pass.
3. Provide a list of barcodes in fasta format. The order of the barcodes is important and should follow the format SALEP_BCXX (X stands for one digit). The barcodenames should not skip a number and the length of each barcode needs to be the same.
```
barcodes.fasta example:
>SALEP_BC01
NNNNNNNN
>SALEP_BC02
NNNNNNNN
>SALEP_BC03
NNNNNNNN
.
.
.
>SALEP_BC21
NNNNNNNN
```

4. Specify the total number of all barcodes in the file barcodes_arrangement.toml by editing last_index = ?.
5. Provide sequences flanking the barcode (e.g. Primers) by editing the file barcodes_arrangement.toml
5.1. edit mask1_front for a sequence at the 5' end of the barcode (in quotes "")
5.2. edit mask2_rear for a sequence at the 3' end of the barcode (in quotes "")
5.3. if either one has been defined the other can be empty (mask1_front = "" or mask1_rear = "")
6. Provide the list of samples by editing the sample_sheet.csv. You should only edit the columns alias and barcode. In the column alias fill in the sample names and in the column barcode provide the barcode in the format barcodeXX (Where XX refers to the digits XX in SALEP_BCXX in the file barcodes.fasta). Note that this is a csv file and each column is delimited by a ",".
7. Run the pipeline by executing the run_salep_ITS_detection_pipeline.sh
8. After a while your results should be in snakemake_workflow/results
9. To reset the Pipeline for another analysis run simply remove the results folder completely or move it somewhere else. Edit the configuration files accordingly for the next run.
