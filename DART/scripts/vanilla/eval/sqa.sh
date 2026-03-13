#!/bin/bash

export CUDA_VISIBLE_DEVICES=0

CKPT=${CKPT:-YOUR_MODEL_PATH} 
MODEL=llava-vanilla-7b

reduction_ratio=$1
max_num_trunction=$2

python -m llava.eval.model_vqa_science \
    --model-path $CKPT \
    --question-file ./playground/data/eval/scienceqa/llava_test_CQM-A.json \
    --image-folder ./playground/data/eval/scienceqa/images/test \
    --answers-file ./playground/data/eval/scienceqa/answers/$MODEL.jsonl \
    --single-pred-prompt \
    --temperature 0 \
    --conv-mode vicuna_v1 

python llava/eval/eval_science_qa.py \
    --base-dir ./playground/data/eval/scienceqa \
    --result-file ./playground/data/eval/scienceqa/answers/$MODEL.jsonl \
    --output-file ./playground/data/eval/scienceqa/answers/${MODEL}_output.jsonl \
    --output-result ./playground/data/eval/scienceqa/answers/${MODEL}_result.json
