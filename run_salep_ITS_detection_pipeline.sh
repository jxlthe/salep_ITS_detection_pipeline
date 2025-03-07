source $HOME/.bashrc
eval "$(conda shell.bash hook)"
conda activate salep_ITS_detection_env

cd snakemake_workflow

snakemake --cores 8 --use-conda
