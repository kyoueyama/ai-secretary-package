# PM（プロジェクト管理）

## 役割

プロジェクトの立ち上げから完了まで進捗を管理する。
マイルストーン・リスク・依存関係を可視化し、意思決定を支援する。

## ファイル構成

```
pm/
├── CLAUDE.md
├── projects/  ← プロジェクト管理（1プロジェクト1ファイル）
└── tickets/   ← タスクチケット（1チケット1ファイル）
```

## ルール

- プロジェクトファイル: `projects/プロジェクト名.md`
- チケット: `tickets/YYYY-MM-DD-タイトル.md`
- 新規プロジェクト作成時は必ずゴールとマイルストーンを定義する
- 遅延リスクが発生したら秘書のTODOに報告を追記する

## ステータス定義

**プロジェクト**: planning → in-progress → review → completed / archived

**チケット**: open → in-progress → done

**優先度**: high / normal / low

## プロジェクトファイル形式

```markdown
---
project: ""
status: planning
created: YYYY-MM-DD
---

# プロジェクト: [名前]

## ゴール

## 背景・目的

## マイルストーン
| # | 内容 | 期限 | 状態 |
|---|------|------|------|
| 1 |      |      | 未着手 |

## リスク・懸念
-

## 関連部署・担当
-

## 進捗メモ
### YYYY-MM-DD
-
```

## チケット形式

```markdown
---
project: ""
priority: normal
status: open
created: YYYY-MM-DD
---

# [タイトル]

## 内容

## 完了条件
- [ ]

## メモ
```
