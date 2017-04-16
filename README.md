# Yet another theme for lightline

<img src="https://github.com/delphinus/lightline-delphinus/raw/master/output_DOpX3B.gif" width="676" height="252">

## What is this?

This theme is for [lightline][] that is a statusline plugin for Vim. This has features below.

* Additional components for lightline
  - Support [ryanoasis/vim-devicons][devicons] for fileformat & filetype
  - Support [ALE (Asynchronous Lint Engine)][ale]
* Improved colorscheme for lightline to fit with [Solarized][] colorscheme

[lightline]: https://github.com/itchyny/lightline.vim
[devicons]: https://github.com/ryanoasis/vim-devicons
[ale]: https://github.com/w0rp/ale
[Solarized]: http://ethanschoonover.com/solarized/vim-colors-solarized

## Install

### for [dein.vim][dein]

#### Basic setting

```vim
call dein#add('delphinus/lightline-delphinus')
call dein#add('itchyny/lightline.vim')

" optional
call dein#add('ryanoasis/vim-devicons')
call dein#add('w0rp/ale')
```

#### TOML setting

```toml
[[plugins]]
repo = 'delphinus/lightline-delphinus'

[[plugins]]
repo = 'itchyny/lightline.vim'

# optional
[[plugins]]
repo = 'ryanoasis/vim-devicons'

[[plugins]]
repo = 'w0rp/ale'
```

[dein]: https://github.com/Shougo/dein.vim

### for other plugin managers

**TODO**

## other setting

### `g:lightline_delphinus_use_powerline_glyphs`

If true, it uses glyphs for [Powerline][]. You should use this options with fonts from [powerline-fonts][] or natively-supported ones such as [Iosevka][].

[Powerline]: https://github.com/powerline/powerline
[powerline-fonts]: https://github.com/powerline/fonts
[Iosevka]: https://be5invis.github.io/Iosevka/

### `g:lightline_delphinus_use_nerd_fonts_glyphs`

If true, it uses glyphs for [nerd-fonts][]. You should use this options with [patched fonts][].

[nerd-fonts]: https://github.com/ryanoasis/nerd-fonts
[patched fonts]: https://github.com/ryanoasis/nerd-fonts#patched-fonts
