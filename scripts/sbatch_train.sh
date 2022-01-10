#!/bin/bash
#SBATCH --partition=gpu
#SBATCH --job-name=train_run
#SBATCH --mem=32G
#SBATCH --time=8:00:00
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=16

set -e
set -x

PYTHONPATH=$(readlink -e .):$PYTHONPATH
export PYTHONPATH
PYTHON="/scratch/wei.guo/conda_envs/ms2/bin/python"

DATA_DIR="/scratch/wei.guo/ms2_data"
OUTPUTS="$DATA_DIR/outputs"

training_reviews_file=$OUTPUTS/text_to_text/training.jsonl
validation_reviews_file=$OUTPUTS/text_to_text/validation.jsonl
testing_reviews_file=$OUTPUTS/text_to_text/testing.jsonl

training_dir=$OUTPUTS/text_to_text/training/bart-base/
EPOCHS=8
GRAD_ACCUM=16
MODEL_NAME='facebook/bart-base'

$PYTHON ms2/models/transformer_summarizer.py \
--train $training_reviews_file \
--val $validation_reviews_file \
--training_root $training_dir \
--epochs=$EPOCHS \
--grad_accum=$GRAD_ACCUM \
--fp16 \
--model_name $MODEL_NAME \
--max_num_refs 4   # Lower this