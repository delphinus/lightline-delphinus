" =============================================================================
" Filename: plugin/lightline_delphinus.vim
" Author: delphinus
" License: MIT License
" Last Change: 2017-04-15T16:26:54+0900.
" =============================================================================

scriptencoding utf-8

if exists('g:loaded_lightline_delphinus')
  finish
endif
let g:loaded_lightline_delphinus = 1

let s:save_cpo = &cpoptions
set cpoptions&vim

let g:lightline = {
        \ 'colorscheme': 'solarized_custom',
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
        \   'modified':     'lightline_delphinus#components#modified',
        \   'readonly':     'lightline_delphinus#components#readonly',
        \   'fugitive':     'lightline_delphinus#components#fugitive',
        \   'filepath':     'lightline_delphinus#components#filepath',
        \   'filename':     'lightline_delphinus#components#filename',
        \   'fileformat':   'lightline_delphinus#components#fileformat',
        \   'filetype':     'lightline_delphinus#components#filetype',
        \   'fileencoding': 'lightline_delphinus#components#fileencoding',
        \   'mode':         'lightline_delphinus#components#mode',
        \   'char_code':    'lightline_delphinus#components#charcode',
        \ },
        \ 'component_function_visible_condition': {
        \   'mode': 1,
        \ },
        \ 'component_expand': {
        \   'ale_error':   'lightline_delphinus#components#ale_error',
        \   'ale_warning': 'lightline_delphinus#components#ale_warning',
        \   'ale_ok':      'lightline_delphinus#components#ale_ok',
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
