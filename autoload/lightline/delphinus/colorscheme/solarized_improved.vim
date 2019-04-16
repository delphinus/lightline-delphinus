" =============================================================================
" Filename: autoload/lightline/delphinus/colorscheme/solarized_improved.vim
" Author: delphinus
" License: MIT License
" Last Change: 2019-04-16T20:28:37+0900.
" =============================================================================

let s:cuicolors = {
      \ 'base03': [ '8', '234', 'DarkGray' ],
      \ 'base02': [ '0', '235', 'Black' ],
      \ 'base01': [ '10', '239', 'LightGreen' ],
      \ 'base00': [ '11', '240', 'LightYellow' ],
      \ 'base0':  [ '12', '244', 'LightBlue' ],
      \ 'base1':  [ '14', '245', 'LightCyan' ],
      \ 'base2': [ '7', '187', 'LightGray' ],
      \ 'base3': [ '15', '230', 'White' ],
      \ 'yellow': [ '3', '136', 'DarkYellow' ],
      \ 'orange': [ '9', '166', 'LightRed' ],
      \ 'red': [ '1', '124', 'DarkRed' ],
      \ 'magenta': [ '5', '125', 'DarkMagenta' ],
      \ 'violet': [ '13', '61', 'LightMagenta' ],
      \ 'blue': [ '4', '33', 'DarkBlue' ],
      \ 'cyan': [ '6', '37', 'DarkCyan' ],
      \ 'green': [ '2', '64', 'DarkGreen' ],
      \ }

" The following condition only applies for the console and is the same
" condition vim-colors-solarized uses to determine which set of colors
" to use.
let s:solarized_termcolors = get(g:, 'solarized_termcolors', 256)
if s:solarized_termcolors != 256 && &t_Co >= 16
  let s:cuiindex = 0
elseif s:solarized_termcolors == 256
  let s:cuiindex = 1
else
  let s:cuiindex = 2
endif

let s:base03 = [ '#002b36', s:cuicolors.base03[s:cuiindex] ]
let s:base02 = [ '#073642', s:cuicolors.base02[s:cuiindex] ]
let s:base01 = [ '#586e75', s:cuicolors.base01[s:cuiindex] ]
let s:base00 = [ '#657b83', s:cuicolors.base00[s:cuiindex] ]
let s:base0 = [ '#839496', s:cuicolors.base0[s:cuiindex] ]
let s:base1 = [ '#93a1a1', s:cuicolors.base1[s:cuiindex] ]
let s:base2 = [ '#eee8d5', s:cuicolors.base2[s:cuiindex] ]
let s:base3 = [ '#fdf6e3', s:cuicolors.base3[s:cuiindex] ]
let s:yellow = [ '#b58900', s:cuicolors.yellow[s:cuiindex] ]
let s:orange = [ '#cb4b16', s:cuicolors.orange[s:cuiindex] ]
let s:red = [ '#dc322f', s:cuicolors.red[s:cuiindex] ]
let s:magenta = [ '#d33682', s:cuicolors.magenta[s:cuiindex] ]
let s:violet = [ '#6c71c4', s:cuicolors.violet[s:cuiindex] ]
let s:blue = [ '#268bd2', s:cuicolors.blue[s:cuiindex] ]
let s:cyan = [ '#2aa198', s:cuicolors.cyan[s:cuiindex] ]
let s:green = [ '#859900', s:cuicolors.green[s:cuiindex] ]

let s:bold = 'bold'

if &background ==# 'light'
  let [ s:base03, s:base3 ] = [ s:base3, s:base03 ]
  let [ s:base02, s:base2 ] = [ s:base2, s:base02 ]
  let [ s:base01, s:base1 ] = [ s:base1, s:base01 ]
  let [ s:base00, s:base0 ] = [ s:base0, s:base00 ]

  " http://paletton.com/#uid=13C0u0knVYVc7ZQi-ZntrXrH4Ty
  let s:insert = [
        \ [ s:base02, s:blue, s:bold ],
        \ [ s:base3, [ '#a4ccfc', 153 ] ],
        \ [ s:base3, [ '#75b2fb', 111 ] ],
        \ [ s:base2, [ '#4e9cf9', 75 ] ],
        \ [ s:base03, [ '#4e9cf9', 75 ] ],
        \ [ s:base2, [ '#2684f5', 33 ] ],
        \ [ s:base2, [ '#4e9cf9', 75 ] ] ]
  " http://paletton.com/#uid=1090u0kkh++7z+WeL+ZpN+WvYZG
  let s:replace = [
        \ [ s:base02, s:red, s:bold ],
        \ [ s:base3, [ '#ffcec3', 224 ] ],
        \ [ s:base3, [ '#ffa089', 216 ] ],
        \ [ s:base2, [ '#ff7c5d', 209 ] ],
        \ [ s:base03, [ '#ff7c5d', 209 ] ],
        \ [ s:base2, [ '#ff5931', 203 ] ],
        \ [ s:base2, [ '#ff7c5d', 209 ] ] ]
  " http://paletton.com/#uid=14Q0u0kcNYG00++6C+qhYVrmpPi
  let s:visual = [
        \ [ s:base02, s:magenta, s:bold ],
        \ [ s:base3, [ '#ffffff', 231 ] ],
        \ [ s:base3, [ '#f5cafd', 225 ] ],
        \ [ s:base2, [ '#e898f9', 177 ] ],
        \ [ s:base03, [ '#e898f9', 177 ] ],
        \ [ s:base2, [ '#d96df0', 171 ] ],
        \ [ s:base2, [ '#e898f9', 177 ] ] ]
else
  " http://paletton.com/#uid=13C0u0kw0w0jyC+oRxVy4oIDfjr
  let s:insert = [
          \ [ s:blue, s:base2, s:bold ],
          \ [ s:base03, [ '#5383bd', 67 ] ],
          \ [ s:base03, [ '#3169ac', 61 ] ],
          \ [ s:base2, [ '#0e53a7', 25 ] ],
          \ [ s:base03, [ '#0e53a7', 25 ] ],
          \ [ s:base2, [ '#0a4081', 24 ] ],
          \ [ s:base2, [ '#0e53a7', 25 ] ] ]
  " http://paletton.com/#uid=1090u0kw0w0jyC+oRxVy4oIDfjr
  let s:replace = [
        \ [ s:red, s:base2, s:bold ],
        \ [ s:base03, [ '#ff8e63', 209 ] ],
        \ [ s:base03, [ '#ff5f39', 203 ] ],
        \ [ s:base2, [ '#ff3100', 202 ] ],
        \ [ s:base03, [ '#ff5f39', 203 ] ],
        \ [ s:base2, [ '#c52600', 160 ] ],
        \ [ s:base2, [ '#ff5f39', 203 ] ] ]
  " http://paletton.com/#uid=14Q0u0kw0w0jyC+oRxVy4oIDfjr
  let s:visual = [
        \ [ s:magenta, s:base2, s:bold ],
        \ [ s:base03, [ '#aa4dbe', 133 ] ],
        \ [ s:base03, [ '#962aad', 92 ] ],
        \ [ s:base2, [ '#8c04a8', 91 ] ],
        \ [ s:base03, [ '#962aad', 92 ] ],
        \ [ s:base2, [ '#6c0382', 54 ] ],
        \ [ s:base2, [ '#962aad', 92 ] ] ]
endif

let s:normal = [
        \ [ s:base03, s:green, s:bold ],
        \ [ s:base03, s:base1, s:bold ],
        \ [ s:base03, s:base0 ],
        \ [ s:base3, s:base02 ],
        \ [ s:base2, s:red ],
        \ [ s:base2, s:yellow ],
        \ [ s:green, s:base02 ] ]

if &background ==# 'light'
  let s:normal[4][0] = s:base02
  let s:normal[5][0] = s:base02
endif

let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}

let s:p.normal.left     = s:normal[0:3]
let s:p.inactive.left   = [ [ s:base0, s:base02 ], [ s:base0, s:base02 ] ]
let s:p.insert.left     = s:insert[0:3]
let s:p.replace.left    = s:replace[0:3]
let s:p.visual.left     = s:visual[0:3]

let s:p.normal.right    = [ [ s:base03, s:base1 ], [ s:base03, s:base00 ] ]
let s:p.inactive.right  = [ [ s:base03, s:base00 ], [ s:base0, s:base02 ] ]
let s:p.insert.right    = s:insert[1:2] + s:insert[4:4]
let s:p.replace.right   = s:replace[1:2] + s:replace[4:4]
let s:p.visual.right    = s:visual[1:2] + s:visual[4:4]

let s:p.normal.middle   = [ [ s:base1, s:base02 ] ]
let s:p.inactive.middle = [ [ s:base01, s:base02 ] ]
let s:p.insert.middle   = s:insert[5:5]
let s:p.replace.middle  = s:replace[5:5]
let s:p.visual.middle   = s:visual[5:5]

let s:p.tabline.left    = [ [ s:base03, s:base00 ] ]
let s:p.tabline.tabsel  = [ [ s:base03, s:base1 ] ]
let s:p.tabline.middle  = [ [ s:base0, s:base02 ] ]
let s:p.tabline.right   = copy(s:p.normal.right)

let s:p.normal.error    = s:normal[4:4]
let s:p.insert.error    = s:insert[6:6]
let s:p.replace.error   = s:replace[6:6]
let s:p.visual.error    = s:visual[6:6]
let s:p.normal.warning  = s:normal[5:5]
let s:p.insert.warning  = s:insert[6:6]
let s:p.replace.warning = s:replace[6:6]
let s:p.visual.warning  = s:visual[6:6]
let s:p.normal.ok       = s:normal[6:6]
let s:p.insert.ok       = s:insert[6:6]
let s:p.replace.ok      = s:replace[6:6]
let s:p.visual.ok       = s:visual[6:6]

function! lightline#delphinus#colorscheme#solarized_improved#palette() abort
  return substitute(string(lightline#colorscheme#flatten(s:p)), ' ', '', 'g')
endfunction
