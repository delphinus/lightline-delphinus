" =============================================================================
" Filename: plugin/lightline_delphinus.vim
" Author: delphinus
" License: MIT License
" Last Change: 2017-07-22T16:59:27+0900.
" =============================================================================

scriptencoding utf-8

if exists('g:loaded_lightline_delphinus')
  finish
endif
let g:loaded_lightline_delphinus = 1

let s:save_cpo = &cpoptions
set cpoptions&vim

let g:lightline_delphinus_use_powerline_glyphs = get(g:, 'lightline_delphinus_use_powerline_glyphs', 0)
let g:lightline_delphinus_use_nerd_fonts_glyphs = get(g:, 'lightline_delphinus_use_nerd_fonts_glyphs', 0)

if g:lightline_delphinus_use_powerline_glyphs
  let s:separator = {'left': '', 'right': ''}
  let s:subseparator = {'left': '', 'right': ''}
else
  let s:separator = {'left': '', 'right': ''}
  let s:subseparator = {'left': '|', 'right': '|'}
endif

let g:lightline = {
        \ 'colorscheme': 'solarized_improved',
        \ 'mode_map': {'c': 'NORMAL'},
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ], [ 'fugitive' ], [ 'filepath' ], [ 'filename' ] ],
        \   'right': [
        \     [ 'lineinfo' ],
        \     [ 'percent' ],
        \     [ 'ale_error', 'ale_warning', 'ale_ok', 'char_code', 'fileformat', 'fileencoding', 'filetype' ],
        \   ],
        \ },
        \ 'inactive': {
        \   'left': [ [ 'filepath', 'filename' ] ],
        \   'right': [ [ 'lineinfo' ], [ 'percent' ] ],
        \ },
        \ 'component_function': {
        \   'modified':     'lightline#delphinus#components#modified',
        \   'readonly':     'lightline#delphinus#components#readonly',
        \   'fugitive':     'lightline#delphinus#components#fugitive',
        \   'filepath':     'lightline#delphinus#components#filepath',
        \   'filename':     'lightline#delphinus#components#filename',
        \   'fileformat':   'lightline#delphinus#components#fileformat',
        \   'filetype':     'lightline#delphinus#components#filetype',
        \   'fileencoding': 'lightline#delphinus#components#fileencoding',
        \   'mode':         'lightline#delphinus#components#mode',
        \   'char_code':    'lightline#delphinus#components#charcode',
        \ },
        \ 'component_function_visible_condition': {
        \   'mode': 1,
        \ },
        \ 'component_expand': {
        \   'ale_error':   'lightline#delphinus#components#ale_error',
        \   'ale_warning': 'lightline#delphinus#components#ale_warning',
        \   'ale_ok':      'lightline#delphinus#components#ale_ok',
        \ },
        \ 'component_type': {
        \   'ale_error':   'error',
        \   'ale_warning': 'warning',
        \   'ale_ok':      'ok',
        \ },
        \ 'separator': s:separator,
        \ 'subseparator': s:subseparator,
        \ }

augroup LightLineOnALE
  autocmd!
  autocmd User ALELint call lightline#update()
augroup END

let &cpoptions = s:save_cpo
unlet s:save_cpo
