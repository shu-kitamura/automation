# Next.js プロジェクト初期化スクリプト

`setup-next-project.sh` は、Next.js (App Router / TypeScript / Tailwind) の新規プロジェクト作成と、`oxlint` / `oxfmt` の初期設定をまとめて自動化するスクリプトです。

## 対象ファイル

- `automation/nextjs/setup-next-project.sh`

## 前提条件

以下のコマンドがインストール済みである必要があります。

- `pnpm`
- `jq`

`pnpm` または `jq` が見つからない場合、スクリプトはエラーメッセージを表示して終了します。

## 使い方

```bash
bash automation/nextjs/setup-next-project.sh <app-name>
```

例:

```bash
bash automation/nextjs/setup-next-project.sh my-next-app
```

## スクリプトが実行する内容

1. `create-next-app@latest` でプロジェクトを作成
2. 開発依存関係として `oxlint` と `oxfmt` を追加
3. `oxlint` / `oxfmt` の設定ファイルを初期化
4. `.oxlintrc.json` / `.oxfmtrc.json` の `ignorePatterns` に以下を追加
   - `dist`
   - `.next`
   - `node_modules`
5. `package.json` に次の scripts を追加
   - `lint`: `oxlint`
   - `lint:fix`: `oxlint --fix`
   - `format`: `oxfmt --check`
   - `format:fix`: `oxfmt`

## `create-next-app` のオプション

スクリプトでは次の条件でプロジェクトを作成します。

- TypeScript: 有効 (`--ts`)
- Tailwind CSS: 有効 (`--tailwind`)
- React Compiler: 有効 (`--react-compiler`)
- ESLint: 無効 (`--no-linter`)
- App Router: 有効 (`--app`)
- `src/` ディレクトリ構成: 有効 (`--src-dir`)
- パッケージマネージャー: `pnpm` (`--use-pnpm`)
- 対話なし: 有効 (`--yes`)

## 補足

- 引数 `<app-name>` が未指定の場合は使用方法を表示して終了します。
- スクリプトは実行後、呼び出し元ディレクトリに戻ります。
