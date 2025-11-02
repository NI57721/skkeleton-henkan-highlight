# skkeleton-henkan-highlight
([英語のドキュメントはこちら](README.md)) \
[skkeleton](https://github.com/vim-skk/skkeleton) で変換中の文字をハイライトする為の Vim / Neovim プラグインです。

![screenshot](https://raw.githubusercontent.com/NI57721/skkeleton-henkan-highlight/assets/screenshot.gif)

## インストール
お好きなプラグイン・マネージャーを使用してください。

## 依存プラグイン
[denops.vim](https://github.com/vim-denops/denops.vim) \
[skkeleton](https://github.com/vim-skk/skkeleton)

## 使用方法
ユーザーが`SkkeletonHenkan`と`SkkeletonHenkanSelect`という変換グループを定義すると、それを使って変換中の文字にハイライトを当てることができます。

### 設定例
```vim
" ノーマル・ターミナルでは変換中に下線を引き、
" カラー・ターミナルでは変換中に色を反転する
highlight SkkeletonHenkan
\ gui=underline term=underline cterm=underline
highlight SkkeletonHenkanSelect
\ gui=underline,reverse term=underline,reverse cterm=underline,reverse
```

## ライセンス
MITライセンス

