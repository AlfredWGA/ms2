for subset in training validation testing ; do
    sbatch scripts/sbatch_preprocess.sh $subset
done