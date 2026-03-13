#!/bin/bash

export CUDA_VISIBLE_DEVICES=0

CKPT=/mnt/data1/qiumingyang/models/llava-v1.5-7b
MODEL=llava-vanilla-7b

reduction_ratio=$1
max_num_trunction=$2

python -m llava.eval.model_vqa_loader \
    --model-path $CKPT \
    --question-file ./playground/data/eval/pope/llava_pope_test.jsonl \
    --image-folder ./playground/data/eval/pope/val2014 \
    --answers-file ./playground/data/eval/pope/answers/$MODEL.jsonl \
    --temperature 0 \
    --conv-mode vicuna_v1 \
    --image_token_start_index 35 \
    --image_token_length 576

python llava/eval/eval_pope.py \
    --annotation-dir ./playground/data/eval/pope/coco \
    --question-file ./playground/data/eval/pope/llava_pope_test.jsonl \
    --result-file ./playground/data/eval/pope/answers/$MODEL.jsonl
