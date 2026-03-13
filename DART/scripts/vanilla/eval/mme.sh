#!/bin/bash

export CUDA_VISIBLE_DEVICES=0

# For vanilla evaluation, CKPT defaults to the provided path if not set externally
CKPT=${CKPT:-/mnt/data1/qiumingyang/models/llava-v1.5-7b}
MODEL=llava-vanilla-7b

python -m llava.eval.model_vqa_loader \
    --model-path $CKPT \
    --question-file ./playground/data/eval/MME/llava_mme.jsonl \
    --image-folder ./playground/data/eval/MME/MME_Benchmark_release_version/MME_Benchmark \
    --answers-file ./playground/data/eval/MME/answers/$MODEL.jsonl \
    --temperature 0 \
    --conv-mode vicuna_v1 \
    --image_token_start_index 35 \
    --image_token_length 576


cd ./playground/data/eval/MME

python convert_answer_to_mme.py --experiment $MODEL

cd eval_tool

python calculation.py --results_dir answers/$MODEL
