# skkeleton-henkan-highlight
([Here is the Japanese document](README-ja.md))  
A Vim / Neovim plugin to highlight words during henkan in [skkeleton](https://github.com/vim-skk/skkeleton).
![screenshot](https://raw.githubusercontent.com/NI57721/skkeleton-state-popup/assets/screenshot.gif)

## Installation
You can use your preferred plugin manager.

## Prerequisite
[denops.vim](https://github.com/vim-denops/denops.vim)  
[skkeleton](https://github.com/vim-skk/skkeleton)

## Usage
This plugin provides a hightlight group, `SkkeletonHenkan`, which allows you to highlight words during henkan.

### Example
```vim
" Highlight words with underline when using a normal terminal,
" and with reverse when using a colour one.
highlight SkkeletonHenkan term=underline cterm=reverse
```

## Licence
MIT Licence

