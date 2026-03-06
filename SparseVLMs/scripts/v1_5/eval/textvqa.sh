#!/bin/bash
export CUDA_VISIBLE_DEVICES=1

CKPT=${CKPT:-YOUR_MODEL_PATH}
MODEL=llava-v1.5-7b

python3 -m llava.eval.model_vqa_loader \
    --model-path $CKPT \
    --question-file /mnt/data1/qiumingyang/github/SparseVLMs/playground/data/eval/textvqa/llava_textvqa_val_v051_ocr.jsonl \
    --image-folder /mnt/data1/qiumingyang/github/SparseVLMs/playground/data/eval/textvqa/train_images \
    --answers-file /mnt/data1/qiumingyang/github/SparseVLMs/playground/data/eval/textvqa/answers/${MODEL}.jsonl \
    --num-chunks 1 \
    --chunk-idx 0 \
    --temperature 0 \
    --conv-mode vicuna_v1 

python3 -m llava.eval.eval_textvqa \
    --annotation-file /mnt/data1/qiumingyang/github/SparseVLMs/playground/data/eval/textvqa/TextVQA_0.5.1_val.json \
    --result-file /mnt/data1/qiumingyang/github/SparseVLMs/playground/data/eval/textvqa/answers/${MODEL}.jsonl