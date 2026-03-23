#!/bin/bash

# AI秘書パッケージ インストーラー
# © 2026 Kyoueyama. All rights reserved.

set -e

PACKAGE_DIR="$(cd "$(dirname "$0")" && pwd)"
INSTALL_DIR="$(pwd)/.secretary"
TODAY=$(date +%Y-%m-%d)
DOW=$(date +%u)
case $DOW in 1) DAY="月" ;; 2) DAY="火" ;; 3) DAY="水" ;; 4) DAY="木" ;; 5) DAY="金" ;; 6) DAY="土" ;; 7) DAY="日" ;; esac

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  AI秘書パッケージ セットアップ"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# ─── 秘書室のインストール ───────────────────────────

if [ -d "$INSTALL_DIR" ]; then
  echo "⚠️  すでに秘書室が存在します: $INSTALL_DIR"
  printf "上書きしますか？ (y/N): "
  read -r answer
  if [ "$answer" != "y" ] && [ "$answer" != "Y" ]; then
    echo "インストールをキャンセルしました。"
    exit 0
  fi
fi

echo "📁 秘書室を作成中..."
mkdir -p "$INSTALL_DIR/secretary/inbox"
mkdir -p "$INSTALL_DIR/secretary/todos"
mkdir -p "$INSTALL_DIR/secretary/notes"

cp "$PACKAGE_DIR/templates/CLAUDE.md" "$INSTALL_DIR/CLAUDE.md"
cp "$PACKAGE_DIR/templates/secretary/CLAUDE.md" "$INSTALL_DIR/secretary/CLAUDE.md"

TODO_FILE="$INSTALL_DIR/secretary/todos/$TODAY.md"
if [ ! -f "$TODO_FILE" ]; then
  cat > "$TODO_FILE" << EOF
---
date: "$TODAY"
type: daily
---

# $TODAY（$DAY）

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

echo "✅ 秘書室のセットアップ完了"
echo ""

# ─── 部署の追加 ─────────────────────────────────────

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  部署の追加（任意）"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "追加したい部署を選んでください。"
echo "複数選択可。不要な場合はそのままEnter。"
echo ""
echo "  [1] 営業       - クライアント管理・提案書"
echo "  [2] マーケティング - コンテンツ・SNS・集客"
echo "  [3] PM         - プロジェクト進捗管理"
echo "  [4] 経理       - 請求・経費・売上管理"
echo "  [5] リサーチ   - 市場・競合調査"
echo "  [6] 開発       - 技術ドキュメント・設計"
echo "  [7] クリエイティブ - デザイン・ブランド"
echo "  [8] 人事       - 採用・チーム管理"
echo "  [all] すべて追加"
echo ""
printf "番号をスペース区切りで入力 (例: 1 3 4): "
read -r selections

install_department() {
  local key="$1"
  local label="$2"
  local dir="$3"
  local subdirs="$4"

  echo "  📂 $label を追加中..."
  mkdir -p "$INSTALL_DIR/$dir"
  cp "$PACKAGE_DIR/templates/departments/$dir/CLAUDE.md" "$INSTALL_DIR/$dir/CLAUDE.md"
  for sub in $subdirs; do
    mkdir -p "$INSTALL_DIR/$dir/$sub"
  done
  echo "  ✅ $label"
}

if echo "$selections" | grep -qw "all\|1"; then
  install_department "1" "営業" "sales" "clients proposals"
fi
if echo "$selections" | grep -qw "all\|2"; then
  install_department "2" "マーケティング" "marketing" "content-plan campaigns"
fi
if echo "$selections" | grep -qw "all\|3"; then
  install_department "3" "PM" "pm" "projects tickets"
fi
if echo "$selections" | grep -qw "all\|4"; then
  install_department "4" "経理" "finance" "invoices expenses"
fi
if echo "$selections" | grep -qw "all\|5"; then
  install_department "5" "リサーチ" "research" "topics"
fi
if echo "$selections" | grep -qw "all\|6"; then
  install_department "6" "開発" "engineering" "docs debug-log"
fi
if echo "$selections" | grep -qw "all\|7"; then
  install_department "7" "クリエイティブ" "creative" "briefs assets"
fi
if echo "$selections" | grep -qw "all\|8"; then
  install_department "8" "人事" "hr" "hiring"
fi

# ─── 完了 ────────────────────────────────────────────

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  セットアップ完了！"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "インストール先: $INSTALL_DIR"
echo ""
echo "Claude Code を起動して、秘書に話しかけてみてください。"
echo ""
echo "  「今日の優先課題を整理して」"
echo "  「〇〇について壁打ちしたい」"
echo "  「ダッシュボードを見せて」"
echo ""
echo "後から部署を追加したい場合:"
echo "  bash $PACKAGE_DIR/add-department.sh"
echo ""
