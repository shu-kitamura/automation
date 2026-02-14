# uv Project Setup Script

`setup-uv-project.sh` は、`python + uv` の新規プロジェクトを最小構成で自動セットアップするスクリプトです。

## 対象ファイル

- `uv/setup-uv-project.sh`

## 前提条件

- `uv` コマンドがインストール済みであること
- Bash で実行すること

## 使い方

`setup-uv-project.sh` を実行したディレクトリ配下に、指定したプロジェクト名で初期化します。

```bash
./uv/setup-uv-project.sh <project-name>
```

例:

```bash
./uv/setup-uv-project.sh hello
```

## スクリプトが実行する処理

1. `uv init <project-name> --vcs git` でプロジェクトを作成
2. 開発用依存を追加
   - `ruff`
   - `ty`
   - `pytest`
3. `src/YOUR_APP_NAME` と `tests` ディレクトリを作成
4. `main.py` を `src/YOUR_APP_NAME/` に移動
5. `tests/__init__.py` を作成
6. `tests/test_example.py` に簡単な smoke test を作成

## 生成される追加構成（抜粋）

```text
<project-name>/
  src/
    YOUR_APP_NAME/
      main.py
  tests/
    __init__.py
    test_example.py
```

## 注意点

- `src/YOUR_APP_NAME` はプレースホルダーです。実際のアプリ名にリネームしてください。
- 引数なしで実行するとエラーになります。必ず `<project-name>` を指定してください。
