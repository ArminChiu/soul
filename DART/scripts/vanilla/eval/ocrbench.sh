#!/bin/bash

export CUDA_VISIBLE_DEVICES=0

reduction_ratio=$1
max_num_trunction=$2

CKPT=/mnt/data1/qiumingyang/models/llava-v1.5-7b
MODEL=llava-vanilla-7b

GPU_Nums=$(echo $CUDA_VISIBLE_DEVICES | tr -cd '0-9' | wc -m)
echo "GPU_NUM: $GPU_Nums"

save_name="${MODEL}_OCRBench"

python -m llava.eval.model_vqa_ocrbench \
    --model_path $CKPT \
    --image_folder ./playground/data/eval/OCRBench/OCRBench_Images \
    --OCRBench_file ./playground/data/eval/OCRBench/OCRBench/OCRBench.json \
    --output_folder ./playground/data/eval/OCRBench/results  \
    --save_name $save_name \
    --num_workers $GPU_Nums
