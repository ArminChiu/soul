#!/bin/bash
export CUDA_VISIBLE_DEVICES=1

CKPT=${CKPT:-YOUR_MODEL_PATH}
MODEL=llava-v1.5-7b

python3 -m llava.eval.model_vqa_loader \
    --model-path $CKPT \
    --question-file /mnt/data1/qiumingyang/github/SparseVLMs/playground/data/eval/MME/llava_mme.jsonl \
    --image-folder /mnt/data1/qiumingyang/github/SparseVLMs/playground/data/eval/MME/MME_Benchmark_release_version/MME_Benchmark \
    --answers-file  /mnt/data1/qiumingyang/github/SparseVLMs/playground/data/eval/MME/answers/$MODEL.jsonl \
    --temperature 0 \
    --conv-mode vicuna_v1

cd /mnt/data1/qiumingyang/github/SparseVLMs/playground/data/eval/MME

python3 convert_answer_to_mme.py --experiment $MODEL

cd eval_tool

python3 calculation.py --results_dir answers/$MODEL