" =============================================================================
" Filename: autoload/lightline/colorscheme/nord_improved.vim
" Author: delphinus
" License: MIT License
" Last Change: 2018-07-13T12:28:40+0900.
" =============================================================================

let s:nord0 = ['#2E3440', 0 ]
let s:nord1 = ['#3B4252', 0]
let s:nord2 = ['#434C5E', 8 ]
let s:nord3 = ['#4C566A', 8]
let s:nord4 = ['#D8DEE9', 7 ]
let s:nord5 = ['#E5E9F0', 7]
let s:nord6 = ['#ECEFF4', 15]
let s:nord7 = ['#8FBCBB', 14]
let s:nord8 = ['#88C0D0', 6]
let s:nord9 = ['#81A1C1', 4]
let s:nord10 = ['#5E81AC', 12]
let s:nord11 = ['#BF616A', 1]
let s:nord12 = ['#D08770', 11]
let s:nord13 = ['#EBCB8B', 3]
let s:nord14 = ['#A3BE8C', 2]
let s:nord15 = ['#B48EAD', 5]

let s:red = [ '#dc322f', 1 ]
let s:magenta = [ '#d33682', 92 ]
let s:blue = [ '#268bd2', 25 ]
let s:green = [ '#2d8f18', 28 ]

let s:bold = 'bold'

" http://paletton.com/#uid=13C0u0kw0w0jyC+oRxVy4oIDfjr
let s:insert = [
        \ [ s:blue, s:nord5, s:bold ],
        \ [ s:nord5, [ '#5383bd', 67 ] ],
        \ [ s:nord5, [ '#3169ac', 60 ] ],
        \ [ s:nord5, [ '#0e53a7', 25 ] ],
        \ [ s:nord5, [ '#0e53a7', 25 ] ],
        \ [ s:nord5, [ '#0a4081', 24 ] ],
        \ [ s:nord5, [ '#0e53a7', 25 ] ] ]
" http://paletton.com/#uid=1090u0kw0w0jyC+oRxVy4oIDfjr
let s:replace = [
      \ [ s:red, s:nord5, s:bold ],
      \ [ s:nord1, [ '#ff8e63', 209 ] ],
      \ [ s:nord1, [ '#ff5f39', 203 ] ],
      \ [ s:nord5, [ '#ff3100', 202 ] ],
      \ [ s:nord1, [ '#ff5f39', 203 ] ],
      \ [ s:nord5, [ '#c52600', 160 ] ],
      \ [ s:nord5, [ '#ff5f39', 203 ] ] ]
" http://paletton.com/#uid=14Q0u0kw0w0jyC+oRxVy4oIDfjr
let s:visual = [
      \ [ s:magenta, s:nord5, s:bold ],
      \ [ s:nord1, [ '#aa4dbe', 133 ] ],
      \ [ s:nord1, [ '#962aad', 92 ] ],
      \ [ s:nord5, [ '#8c04a8', 91 ] ],
      \ [ s:nord1, [ '#962aad', 92 ] ],
      \ [ s:nord5, [ '#6c0382', 54 ] ],
      \ [ s:nord5, [ '#962aad', 92 ] ] ]

" http://paletton.com/#uid=12R0u0ko0jTe3tEjEo9tdeFBC9s
let s:terminal = [
      \ [ s:green, s:nord5, s:bold ],
      \ [ s:nord1, [ '#67b771', 71 ] ],
      \ [ s:nord1, [ '#3a9545', 65 ] ],
      \ [ s:nord5, [ '#1f7b2a', 28 ] ],
      \ [ s:nord1, [ '#3a9545', 65 ] ],
      \ [ s:nord5, [ '#085b12', 22 ] ],
      \ [ s:nord5, [ '#3a9545', 65 ] ] ]

let s:normal = [
        \ [ s:nord1, s:nord8, s:bold ],
        \ [ s:nord5, s:nord3, s:bold ],
        \ [ s:nord5, s:nord2 ],
        \ [ s:nord6, s:nord1 ],
        \ [ s:nord5, s:nord11 ],
        \ [ s:nord1, s:nord13 ],
        \ [ s:nord14, s:nord1 ] ]

let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}, 'terminal': {}}

let s:p.normal.left     = s:normal[0:3]
let s:p.inactive.left   = [ [ s:nord5, s:nord3 ], [ s:nord5, s:nord2 ] ]
let s:p.insert.left     = s:insert[0:3]
let s:p.replace.left    = s:replace[0:3]
let s:p.visual.left     = s:visual[0:3]
let s:p.terminal.left   = s:terminal[0:3]

let s:p.normal.right    = [ [ s:nord5, s:nord3 ], [ s:nord5, s:nord2 ], [ s:nord5, s:nord1 ] ]
let s:p.inactive.right  = [ [ s:nord5, s:nord2 ], [ s:nord5, s:nord1 ] ]
let s:p.insert.right    = s:insert[1:2] + s:insert[4:4]
let s:p.replace.right   = s:replace[1:2] + s:replace[4:4]
let s:p.visual.right    = s:visual[1:2] + s:visual[4:4]
let s:p.terminal.right  = s:terminal[1:2] + s:terminal[4:4]

let s:p.normal.middle   = [ [ s:nord3, s:nord1 ] ]
let s:p.inactive.middle = [ [ s:nord2, s:nord0 ] ]
let s:p.insert.middle   = s:insert[5:5]
let s:p.replace.middle  = s:replace[5:5]
let s:p.visual.middle   = s:visual[5:5]
let s:p.terminal.middle = s:terminal[5:5]

let s:p.tabline.left    = [ [ s:nord0, s:nord3 ] ]
let s:p.tabline.tabsel  = [ [ s:nord0, s:nord3 ] ]
let s:p.tabline.middle  = [ [ s:nord3, s:nord1 ] ]
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

let g:lightline#colorscheme#nord_improved#palette = lightline#colorscheme#flatten(s:p)
