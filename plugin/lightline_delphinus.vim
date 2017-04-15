" =============================================================================
" Filename: plugin/lightline_delphinus.vim
" Author: delphinus
" License: MIT License
" Last Change: 2017-04-15T20:08:32+0900.
" =============================================================================

scriptencoding utf-8

if exists('g:loaded_lightline_delphinus')
  finish
endif
let g:loaded_lightline_delphinus = 1

let s:save_cpo = &cpoptions
set cpoptions&vim

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
        \ 'separator': { 'left': '', 'right': '' },
        \ 'subseparator': { 'left': '', 'right': '' },
        \ }

augroup LightLineOnALE
  autocmd!
  autocmd User ALELint call lightline#update()
augroup END

let &cpoptions = s:save_cpo
unlet s:save_cpo
