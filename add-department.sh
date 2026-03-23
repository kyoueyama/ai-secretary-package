#!/bin/bash

# AI秘書パッケージ 部署追加スクリプト
# © 2026 Kyoueyama. All rights reserved.

set -e

PACKAGE_DIR="$(cd "$(dirname "$0")" && pwd)"
INSTALL_DIR="$(pwd)/.secretary"

if [ ! -d "$INSTALL_DIR" ]; then
  echo "❌ 秘書室が見つかりません。先に install.sh を実行してください。"
  exit 1
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  部署の追加"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# インストール済みの部署を表示
echo "現在の構成:"
for dir in sales marketing pm finance research engineering creative hr; do
  if [ -d "$INSTALL_DIR/$dir" ]; then
    echo "  ✅ $dir"
  fi
done
echo ""

echo "追加したい部署を選んでください（複数可）:"
echo ""
echo "  [1] 営業       - クライアント管理・提案書"
echo "  [2] マーケティング - コンテンツ・SNS・集客"
echo "  [3] PM         - プロジェクト進捗管理"
echo "  [4] 経理       - 請求・経費・売上管理"
echo "  [5] リサーチ   - 市場・競合調査"
echo "  [6] 開発       - 技術ドキュメント・設計"
echo "  [7] クリエイティブ - デザイン・ブランド"
echo "  [8] 人事       - 採用・チーム管理"
echo ""
printf "番号をスペース区切りで入力: "
read -r selections

add_dept() {
  local dir="$1"
  local label="$2"
  local subdirs="$3"

  if [ -d "$INSTALL_DIR/$dir" ]; then
    echo "  ⚠️  $label はすでに存在します（スキップ）"
    return
  fi
  echo "  📂 $label を追加中..."
  mkdir -p "$INSTALL_DIR/$dir"
  cp "$PACKAGE_DIR/templates/departments/$dir/CLAUDE.md" "$INSTALL_DIR/$dir/CLAUDE.md"
  for sub in $subdirs; do
    mkdir -p "$INSTALL_DIR/$dir/$sub"
  done
  echo "  ✅ $label"
}

echo ""
if echo "$selections" | grep -qw "1"; then add_dept "sales" "営業" "clients proposals"; fi
if echo "$selections" | grep -qw "2"; then add_dept "marketing" "マーケティング" "content-plan campaigns"; fi
if echo "$selections" | grep -qw "3"; then add_dept "pm" "PM" "projects tickets"; fi
if echo "$selections" | grep -qw "4"; then add_dept "finance" "経理" "invoices expenses"; fi
if echo "$selections" | grep -qw "5"; then add_dept "research" "リサーチ" "topics"; fi
if echo "$selections" | grep -qw "6"; then add_dept "engineering" "開発" "docs debug-log"; fi
if echo "$selections" | grep -qw "7"; then add_dept "creative" "クリエイティブ" "briefs assets"; fi
if echo "$selections" | grep -qw "8"; then add_dept "hr" "人事" "hiring"; fi

echo ""
echo "✅ 完了しました。"
echo ""
