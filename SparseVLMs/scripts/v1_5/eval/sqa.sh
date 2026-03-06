#!/bin/bash

export CUDA_VISIBLE_DEVICES=1

CKPT=${CKPT:-YOUR_MODEL_PATH}
MODEL=llava-v1.5-7b

python -m llava.eval.model_vqa_science \
    --model-path $CKPT \
    --question-file ./playground/data/eval/scienceqa/llava_test_CQM-A.json \
    --image-folder ./playground/data/eval/scienceqa/images/test \
    --answers-file  ./playground/data/eval/scienceqa/answers/$MODEL.jsonl \
    --temperature 0 \
    --conv-mode vicuna_v1

CUDA_VISIBLE_DEVICES=0 python llava/eval/eval_science_qa.py \
    --base-dir ./playground/data/eval/scienceqa \
    --result-file ./playground/data/eval/scienceqa/answers/$MODEL.jsonl \
    --output-file ./playground/data/eval/scienceqa/answers/${MODEL}_output.jsonl \
    --output-result ./playground/data/eval/scienceqa/answers/${MODEL}_result.json
