# andar - プロジェクトガイド

強度を使った platformer(Godot 4.6.2 / GDScript)。
リポジトリ共通ルールは `godot-lab/CLAUDE.md` に準拠する。

## ゲームコンセプト

- 強度(1~3)を選んで横移動・ジャンプするアクション
- ボタン長押し不可。単押しのインパルス移動(音ゲーに近い操作感)
- クリアスピード基準のスコアアタック

## シーン構成とフロー

- `scenes/Main.tscn` … エントリポイント(即 Title へ遷移)
- `scenes/Title.tscn` … タイトル(Start / Quit)
- `scenes/Game.tscn` … ゲーム本体(Player / TileMapLayer / Goal / DeathArea)
- 遷移は必ず `SceneManager.change_scene(path)` を使う(フェード付き・二重遷移ガードあり)
- Goal / DeathArea 到達時は Player の physics を止めてから Title へ戻る

## Autoload(project.godot 登録済み)

- `Constants` … 画面サイズ・カラーパレット(`Constants.COLORS.bg` 形式)
- `SceneManager` … フェード付きシーン遷移(CanvasLayer、.tscn で登録)
- `GameState` … score / level 保持。Game 開始時に `reset()` を呼ぶ

## プレイヤー挙動(scripts/player.gd)

- `ui_left` / `ui_right` の単押しで `impulse_speed` を与え、`friction` で減速
- `ui_accept` で接地時のみジャンプ
- 定数: `JUMP_SPEED` / `GRAVITY`、調整値: `@export` の `impulse_speed` / `friction`

## 描画設定(project.godot)

- viewport 320x240、window 640x480、integer scale、ピクセルスナップ有効
- テクスチャフィルタ: Nearest(ピクセルアート前提)
- レンダラ: GL Compatibility(HTML5 配布のため変更しない)

## 注意点

- `Constants.SCREEN_WIDTH/HEIGHT`(960x720)と project.godot の
  viewport(320x240)が現在不一致。画面サイズを触るときは両方を同期させる
- `addons/audio_manager/` は BGM/SE 再生ユーティリティ(現状未使用、bus "BGM"/"SE" 前提)
- 入力アクションは組み込みの `ui_*` を流用中。独自アクション追加時は
  project.godot の InputMap 定義とセットで行う
