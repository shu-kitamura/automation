#!/bin/bash
set -euo pipefail

PWD=$(pwd)
app_name=$1

if ! command -v pnpm >/dev/null 2>&1; then
	echo "pnpm is not installed, so this script cannot run."
	exit 1
fi

if ! command -v jq >/dev/null 2>&1; then
	echo "jq is not installed, so this script cannot run."
	exit 1
fi

if [[ -z "$app_name" ]]; then
	echo "Usage: $0 <app-name>"
	exit 1
fi

# create-next-app
pnpm dlx create-next-app@latest $app_name --ts --tailwind --react-compiler --no-linter --app --src-dir --use-pnpm --yes
cd $app_name

# add linter and formatter
pnpm install -D oxlint oxfmt

# init oxlint and oxfmt
pnpm dlx oxlint --init
pnpm dlx oxfmt --init

# modify .oxlintrc.json and .oxfmtrc.json to ignore common build directories
jq '.ignorePatterns += ["dist", ".next", "node_modules"]' .oxlintrc.json > tmp.$$.json && mv tmp.$$.json .oxlintrc.json
jq '.ignorePatterns += ["dist", ".next", "node_modules"]' .oxfmtrc.json > tmp.$$.json && mv tmp.$$.json .oxfmtrc.json

# add lint and format scripts to package.json
pnpm pkg set scripts.lint="oxlint"
pnpm pkg set scripts.lint:fix="oxlint --fix"
pnpm pkg set scripts.format="oxfmt --check"
pnpm pkg set scripts.format:fix="oxfmt"

# add jest
pnpm add -D jest jest-environment-jsdom @testing-library/react @testing-library/dom @testing-library/jest-dom ts-node @types/jest

# create jest.config.ts
cat > jest.config.ts <<'TS'
import type { Config } from "jest";
import nextJest from "next/jest.js";

const createJestConfig = nextJest({ dir: "./" });

const config: Config = {
  coverageProvider: "v8",
  testEnvironment: "jsdom",
  clearMocks: true,
  setupFilesAfterEnv: ["<rootDir>/jest.setup.ts"],
};

export default createJestConfig(config);
TS

# create jest.setup.ts
cat > jest.setup.ts <<'TS'
import "@testing-library/jest-dom";
TS

# add jest scripts to package.json
pnpm pkg set scripts.test="jest"

# add test example
mkdir -p __tests__

cat > __tests__/example.test.ts <<'TS'
describe("example", () => {
  it("1+1=2", () => {
    expect(1 + 1).toBe(2);
  });
});
TS

# add cache dir to .gitignore
echo ".swc" >> .gitignore

cd $PWD

echo "Next.js (and linter, formatter, test) setup done"
