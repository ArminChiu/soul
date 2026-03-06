#!/usr/bin/env python3
"""
Lightweight evaluation runner that delegates to existing shell eval scripts.
This file mirrors the DART runner so you can run a unified command in both repos.
Usage example:
  python scripts/eval_runner.py --dataset mme --ckpt /path/to/ckpt --gpu 0 -- 0.778 128
"""
import argparse
import os
import subprocess
import sys
import time
import shutil


def find_script(repo_root, dataset, variants=("v1_5", "vanilla")):
    for v in variants:
        candidate = os.path.join(repo_root, "scripts", v, "eval", f"{dataset}.sh")
        if os.path.exists(candidate):
            return candidate
    return None


def main():
    p = argparse.ArgumentParser()
    p.add_argument("--dataset", required=True, help="dataset name, e.g. mme,textvqa")
    p.add_argument("--ckpt", required=True, help="path to checkpoint")
    p.add_argument("--gpu", default="0", help="CUDA_VISIBLE_DEVICES")
    p.add_argument("--output_dir", default="results", help="where to copy outputs")
    p.add_argument("--script", default=None, help="explicit script path to run")
    p.add_argument("--repo_root", default=None, help="repo root (optional)")
    p.add_argument("script_args", nargs=argparse.REMAINDER, help="extra args passed to the bash script")
    args = p.parse_args()

    repo_root = args.repo_root or os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
    script_path = args.script or find_script(repo_root, args.dataset)
    if script_path is None:
        print("Cannot find eval script for dataset", args.dataset, file=sys.stderr)
        sys.exit(2)

    env = os.environ.copy()
    env["CKPT"] = args.ckpt
    env["CUDA_VISIBLE_DEVICES"] = str(args.gpu)

    cmd = ["bash", script_path] + (args.script_args or [])
    print('Running:', ' '.join(cmd))
    start = time.time()
    ret = subprocess.run(cmd, env=env)
    dur = time.time() - start
    print('Return code:', ret.returncode, 'duration: %.1fs' % dur)

    outdir = os.path.abspath(args.output_dir)
    os.makedirs(outdir, exist_ok=True)
    candidates = ["answers", "results", "playground/data/eval"]
    for c in candidates:
        path = os.path.join(repo_root, c)
        if os.path.exists(path):
            dest = os.path.join(outdir, os.path.basename(path))
            if os.path.exists(dest):
                shutil.rmtree(dest)
            try:
                shutil.copytree(path, dest)
            except Exception:
                try:
                    shutil.copy2(path, dest)
                except Exception:
                    pass

    print('Collected outputs to', outdir)
    sys.exit(ret.returncode)


if __name__ == '__main__':
    main()
