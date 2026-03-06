# automation

`automation` は、開発プロジェクトの初期セットアップを自動化するためのスクリプト集です。  
現在は以下の 2 つを提供しています。

- Next.js プロジェクト初期化（TypeScript / Tailwind / App Router / oxlint / oxfmt / Jest）
- Python + uv プロジェクト初期化（ruff / ty / pytest）

## ディレクトリ構成

新たに何か追加する際は以下のようにスクリプトと REAEMD.md をセットで加えるようにしてください。

```text
automation/
  nextjs/
    setup-next-project.sh
    README.md
  uv/
    setup-uv-project.sh
    README.md
```

## 前提条件

- Bash が使える環境
- `nextjs/setup-next-project.sh` を使う場合
  - `pnpm`
  - `jq`
- `uv/setup-uv-project.sh` を使う場合
  - `uv`

## 使い方

各スクリプトの `README.md` を参照してください。

