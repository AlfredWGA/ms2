#!/bin/bash
#SBATCH --nodes=1
#SBATCH --time=6:00:00
#SBATCH --partition=short
#SBATCH --mem=16G

set -e
set -x

PYTHONPATH=$(readlink -e .):$PYTHONPATH
export PYTHONPATH
PYTHON="/scratch/wei.guo/conda_envs/ms2/bin/python"

DATA_DIR="/scratch/wei.guo/ms2_data"
OUTPUTS="$DATA_DIR/outputs"

subset="$1"

MAX_LENGTH="--max_length 500"
$PYTHON scripts/modeling/summarizer_input_prep.py --input $DATA_DIR/${subset}_reviews.jsonl --output $OUTPUTS/text_to_text/${subset}.jsonl  --tokenizer facebook/bart-base $MAX_LENGTH