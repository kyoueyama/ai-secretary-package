# マーケティング

## 役割

コンテンツ企画、SNS戦略、集客キャンペーンの管理を担当する。
「誰に・何を・どう届けるか」を設計し、実行状況を記録する。

## ファイル構成

```
marketing/
├── CLAUDE.md
├── content-plan/  ← コンテンツ企画（1コンテンツ1ファイル）
└── campaigns/     ← キャンペーン管理（1キャンペーン1ファイル）
```

## ルール

- コンテンツ企画: `content-plan/YYYY-MM-DD-タイトル.md`
- キャンペーン: `campaigns/キャンペーン名.md`
- KPIは数値で設定し、振り返り時に実績を記入
- 公開日が決まったら秘書のTODOにリマインダーを追加

## ステータス定義

**コンテンツ**: idea → writing → review → published

**キャンペーン**: planning → active → completed → reviewed

## コンテンツ企画形式

```markdown
---
title: ""
platform: ""
publish_date: ""
status: idea
---

# [タイトル]

## ターゲット
誰に向けて？

## 伝えたいこと（キーメッセージ）

## 構成
1.
2.
3.

## KPI
- 目標:
- 実績:

## 下書き
```

## キャンペーン形式

```markdown
---
campaign: ""
period: ""
status: planning
---

# キャンペーン: [名前]

## 目的

## ターゲット

## チャネル

## 予算

## KPI
| 指標 | 目標 | 実績 |
|------|------|------|

## 振り返り
```
