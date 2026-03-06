# SparseVLMs (subdirectory in main `soul` repo)

说明：此目录为 `SparseVLMs` 项目的代码副本，用作毕业设计的开发基础。为了避免在源代码管理中出现嵌套仓库干扰，当前目录没有初始化为独立的 git 仓库（原始 `.git` 已备份）。

建议：
- 不要在此目录下执行 `git init` 或创建独立仓库。请在主仓库根目录（`soul/`）管理版本控制。
- 若需要恢复原始仓库元数据，可从 `removed_git_backup_<timestamp>/` 中恢复 `.git` 文件夹（若确定要成为独立仓库才执行）。

开发流程示例：
1. 在主仓库根目录创建 feature 分支：`git checkout -b feat/kv-prune-demo`。
2. 在 `SparseVLMs/` 中实现改动并在主仓库提交：`git add SparseVLMs/... && git commit -m "feat: add kv pruning demo"`。

如果你希望此子目录成为独立仓库（子模块或独立项目），我可以帮你说明如何安全迁移或设置子模块（`git submodule` 或 `git subtree`）。
