# Design: copilot-ps send — Copilot paneへの外部指示送信

## 概要

`copilot-ps send <N> "<MESSAGE>"` サブコマンドを追加する。
`copilot-ps` の一覧に番号を振り、その番号で送信先 pane を直接指定して
`tmux send-keys` 経由でメッセージを送る。

## 要件

- `copilot-ps` の一覧表示に 1 始まりの番号を追加する
- `copilot-ps send <N> "<MESSAGE>"` で指定番号の pane へ送信する
- idle（○）状態の pane のみ送信を許可する
- running（🤖）状態の pane への送信はエラーで終了する
- 既存の `-s SESSION` / `-w` フラグと組み合わせ可能

## インターフェース

```bash
# 一覧確認
copilot-ps
copilot-ps -s work

# 送信
copilot-ps send 1 "テストを追加して"
copilot-ps -s work send 1 "テストを追加して"
```

## アーキテクチャ

### データ層: `get_list_copilot_panes()` の出力変更

```
# 変更後: status|task|dir|pane_addr
idle|READMEを更新して|myrepo|0:2.0
running|テストを書く|otherrepo|0:4.0
```

pane_addr (`session:window.pane`) を 4 番目のフィールドとして追加する。

### 表示層: `render()` の変更

各行の先頭に 1 始まりの番号を表示する。

```
  #   TASK                                          DIR
  session: all sessions
────────────────────────────────────────────────────────────
1 ○   READMEを更新して                             myrepo
2 ●   テストを書く                                 otherrepo
```

番号は表示のたびに振り直す（ステートレス）。

### 送信ロジック: `send_command(N, MESSAGE)`

1. `get_list_copilot_panes()` を実行して pane 一覧を配列に格納する
2. インデックス N（1始まり）の行を取り出す
3. `status == running` なら `error: pane N is currently running` で終了
4. `tmux send-keys -t "$pane_addr" "$message" Enter` を実行する
5. 完了メッセージを出力する: `→ sent to pane N (pane_addr)`

### `parse_args()` の変更

`send` を最初の位置引数として検出し、`send_mode=true` に設定する。
`-s` / `-w` の後に `send` が来ても処理できるよう、引数パースの最後にサブコマンドを確認する。

## エラー処理

| ケース | メッセージ |
|---|---|
| 番号が範囲外 | `error: no pane with index N` |
| running 中 | `error: pane N is currently running (🤖 task-name)` |
| tmux pane が消えた | tmux のエラーをそのまま表示 |
| MESSAGE が空 | `error: message cannot be empty` |

## 変更対象ファイル

`dotfiles/func/copilot-ps` のみ

## 変更しないこと

- `-w` watchモードへの `send` の統合（watchループ中は送信不要）
- fzf によるインタラクティブ選択モード（スコープ外）
- running 中の強制送信フラグ（スコープ外）
