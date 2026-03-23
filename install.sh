#!/bin/bash

# AI秘書パッケージ インストーラー
# © 2026 Kyoueyama. All rights reserved.

set -e

PACKAGE_DIR="$(cd "$(dirname "$0")" && pwd)"
INSTALL_DIR="$(pwd)/.secretary"
TODAY=$(date +%Y-%m-%d)

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  AI秘書パッケージ セットアップ"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# すでにインストール済みか確認
if [ -d "$INSTALL_DIR" ]; then
  echo "⚠️  すでに秘書室が存在します: $INSTALL_DIR"
  echo "上書きしますか？ (y/N): "
  read -r answer
  if [ "$answer" != "y" ] && [ "$answer" != "Y" ]; then
    echo "インストールをキャンセルしました。"
    exit 0
  fi
fi

# ディレクトリ作成
echo "📁 秘書室を作成中..."
mkdir -p "$INSTALL_DIR/secretary/inbox"
mkdir -p "$INSTALL_DIR/secretary/todos"
mkdir -p "$INSTALL_DIR/secretary/notes"

# テンプレートをコピー
cp "$PACKAGE_DIR/templates/CLAUDE.md" "$INSTALL_DIR/CLAUDE.md"
cp "$PACKAGE_DIR/templates/secretary/CLAUDE.md" "$INSTALL_DIR/secretary/CLAUDE.md"

# 今日のTODOファイルを作成
TODO_FILE="$INSTALL_DIR/secretary/todos/$TODAY.md"
if [ ! -f "$TODO_FILE" ]; then
  DAY_OF_WEEK=$(date +%A | sed 's/Monday/月/;s/Tuesday/火/;s/Wednesday/水/;s/Thursday/木/;s/Friday/金/;s/Saturday/土/;s/Sunday/日/')
  cat > "$TODO_FILE" << EOF
---
date: "$TODAY"
type: daily
---

# $TODAY（$DAY_OF_WEEK）

## 最優先
- [ ]

## 通常
- [ ]

## 余裕があれば
- [ ]

## 完了

## 所感・振り返り
-
EOF
fi

echo ""
echo "✅ セットアップ完了！"
echo ""
echo "  $INSTALL_DIR"
echo "  ├── CLAUDE.md"
echo "  └── secretary/"
echo "      ├── CLAUDE.md"
echo "      ├── inbox/"
echo "      ├── todos/"
echo "      │   └── $TODAY.md"
echo "      └── notes/"
echo ""
echo "Claude Code を起動して、秘書に話しかけてみてください。"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
