# Yet another theme for lightline

<img src="https://github.com/delphinus/lightline-delphinus/raw/master/demo.gif" width="446" height="280">

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

## Themes

* For Solarized Dark (best match for [vim-solarized8][])  
  <img width="847" alt="2017-11-07 9 15 59" src="https://user-images.githubusercontent.com/1239245/32470747-142ef870-c39d-11e7-8337-353cdb8c838f.png">  
  <img width="847" alt="2017-11-07 9 16 32" src="https://user-images.githubusercontent.com/1239245/32470751-1a1b54fe-c39d-11e7-98f8-e0837fc8eded.png">  
  <img width="847" alt="2017-11-07 9 16 48" src="https://user-images.githubusercontent.com/1239245/32470754-1c9afd56-c39d-11e7-8660-46d72b40601c.png">  
  <img width="847" alt="2017-11-07 9 17 03" src="https://user-images.githubusercontent.com/1239245/32470757-20d18322-c39d-11e7-9218-1d4634a714c6.png">

* For Solarized Light (best match for [vim-solarized8][])  
  <img width="847" alt="2017-11-07 9 17 20" src="https://user-images.githubusercontent.com/1239245/32470813-979b6586-c39d-11e7-928c-d6078ec10cf5.png">  
  <img width="847" alt="2017-11-07 9 17 35" src="https://user-images.githubusercontent.com/1239245/32470816-9b08754c-c39d-11e7-9eea-003a50d2f632.png">  
  <img width="847" alt="2017-11-07 9 17 53" src="https://user-images.githubusercontent.com/1239245/32470819-9e870594-c39d-11e7-8437-d5beb5129592.png">  
  <img width="847" alt="2017-11-07 9 18 05" src="https://user-images.githubusercontent.com/1239245/32470821-a0fcda7e-c39d-11e7-9474-b5af7f62ee39.png">

* For nord ([nord-vim][])
  <img width="847" alt="2017-11-07 9 19 09" src="https://user-images.githubusercontent.com/1239245/32470849-bd82e332-c39d-11e7-9cb0-2a1c3e567f19.png">  
  <img width="847" alt="2017-11-07 9 19 30" src="https://user-images.githubusercontent.com/1239245/32470853-c1191c6e-c39d-11e7-9c63-f7cabd6fca20.png">  
  <img width="847" alt="2017-11-07 9 19 59" src="https://user-images.githubusercontent.com/1239245/32470856-c2ac361a-c39d-11e7-8b51-236671673c6b.png">  
  <img width="847" alt="2017-11-07 9 20 13" src="https://user-images.githubusercontent.com/1239245/32470857-c40b81aa-c39d-11e7-8355-b336a3e3f3f5.png">

[vim-solarized8]: https://github.com/lifepillar/vim-solarized8
[nord-vim]: https://github.com/arcticicestudio/nord-vim

## Install

### for [dein.vim][dein]

#### Basic setting

```vim
call dein#add('delphinus/lightline-delphinus')
call dein#add('itchyny/lightline.vim')

" optional
call dein#add('ryanoasis/vim-devicons')
call dein#add('w0rp/ale')
call dein#add('majutsushi/tagbar')
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

[[plugins]]
repo = 'majutsushi/tagbar'
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

### `g:lightline_delphinus_colorscheme`

Can be set `solarized_improved` (Default) or `nord_improved`.

## ALE setting (optional)

If you want to use neat glyphs statusline for ALE, you should add some settings for ALE. Below is an example that I used in capturing GIF above.

```vim
" nr2char(...) is for describing icons from devicons
let g:ale_echo_msg_error_str = nr2char(0xf421) . ' '
let g:ale_echo_msg_warning_str = nr2char(0xf420) . ' '
let g:ale_echo_msg_info_str = nr2char(0xf05a) . ' '
let g:ale_echo_msg_format = '%severity%  %linter% - %s'
let g:ale_sign_column_always = 1
let g:ale_sign_error = g:ale_echo_msg_error_str
let g:ale_sign_warning = g:ale_echo_msg_warning_str
let g:ale_statusline_format = [
      \ g:ale_echo_msg_error_str . ' %d',
      \ g:ale_echo_msg_warning_str . ' %d',
      \ nr2char(0xf4a1) . '  ']
```

## tagbar setting (optional)

lightline-delphinus can detect installed [tagbar][] and show function names on cursor by `tagbar#current()`. The info from tagbar will be updated once per second at the maximum.

Set `let g:lightline_delphinus_tagbar_enable = 1` to enable this.

[tagbar]: https://github.com/majutsushi/tagbar

<img width="621" alt="2018-07-12 14 22 05" src="https://user-images.githubusercontent.com/1239245/42614066-2914af50-85df-11e8-9465-395a04e6ac82.png">

## gitgutter setting (optional)

lightline-delphinus can detect installed [vim-gitgutter][] and show diff info calculated from `gitgutter#hunk#hunks()`.

Set `let g:lightline_delphinus_gitgutter_enable = 1` to enable this.

[vim-gitgutter]: https://github.com/airblade/vim-gitgutter

<img width="708" alt="2018-10-27 10 43 47" src="https://user-images.githubusercontent.com/1239245/47598330-4db88580-d9d5-11e8-93dd-fdf91d52894a.png">
