" =============================================================================
" Filename: autoload/lightline/delphinus/components.vim
" Author: delphinus
" License: MIT License
" Last Change: 2017-04-15T20:06:56+0900.
" =============================================================================

scriptencoding utf-8

function! lightline#delphinus#components#modified() abort
  return &filetype =~# 'help\|vimfiler\|gundo' ? '' :
        \ &modified ? '' : &modifiable ? '' :
        \ '-'
endfunction

function! lightline#delphinus#components#readonly() abort
  return &filetype ==# 'help' ? '' :
        \ &filetype !~# 'vimfiler\|gundo' && &readonly ? '' :
        \ ''
endfunction

function! lightline#delphinus#components#filepath() abort
  let l:ro_string = '' !=# lightline#delphinus#components#readonly() ? lightline#delphinus#components#readonly() . ' ' : ''
  if &filetype ==# 'vimfilter' || &filetype ==# 'unite' || winwidth(0) < 70
    let l:path_string = ''
  else
    let l:path_string = substitute(expand('%:h'), $HOME, '~', '')
    if winwidth(0) < 120 && len(l:path_string) > 30
      let l:path_string = substitute(l:path_string, '\v([^/])[^/]*%(/)@=', '\1', 'g')
    endif
  endif

  return l:ro_string . l:path_string
endfunction

function! lightline#delphinus#components#filename() abort
  return (&filetype ==# 'vimfiler' ? vimfiler#get_status_string() :
        \  &filetype ==# 'unite' ? unite#get_status_string() :
        \ '' !=# expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' !=# lightline#delphinus#components#modified() ? ' ' . lightline#delphinus#components#modified() : '')
endfunction

function! lightline#delphinus#components#fugitive() abort
  if winwidth(0) < 100
    return ''
  endif
  try
    if &filetype !~? 'vimfiler\|gundo' && exists('*fugitive#head')
      return fugitive#head()
    endif
  catch
  endtry
  return ''
endfunction

function! lightline#delphinus#components#fileformat() abort
  return winwidth(0) > 120 ? &fileformat . (exists('*WebDevIconsGetFileFormatSymbol') ? ' ' . WebDevIconsGetFileFormatSymbol() : '') : ''
endfunction

function! lightline#delphinus#components#filetype() abort
  return winwidth(0) > 120 ? (strlen(&filetype) ? &filetype . (exists('*WebDevIconsGetFileTypeSymbol') ? ' ' . WebDevIconsGetFileTypeSymbol() : '') : 'no ft') : ''
endfunction

function! lightline#delphinus#components#fileencoding() abort
  return winwidth(0) > 120 ? (strlen(&fileencoding) ? &fileencoding : &encoding) : ''
endfunction

function! lightline#delphinus#components#mode() abort
  let l:fname = expand('%:t')
  return l:fname =~# 'unite' ? 'Unite' :
        \ l:fname =~# 'vimfiler' ? 'VimFilter' :
        \ l:fname =~# '__Gundo__' ? 'Gundo' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! lightline#delphinus#components#charcode() abort
  if winwidth(0) <= 120
    return ''
  endif
  redir => l:tmp | silent! ascii | redir END
  let l:m = matchlist(l:tmp, '<\(.\+\)>\s*\(\d\+\)')
  return len(l:m) > 0 ? printf('%s %X', l:m[1], l:m[2]) : ''
endfunction

function! lightline#delphinus#components#ale_error() abort
  return s:ale_string(0)
endfunction

function! lightline#delphinus#components#ale_warning() abort
  return s:ale_string(1)
endfunction

function! lightline#delphinus#components#ale_ok() abort
  return s:ale_string(2)
endfunction

function! s:ale_string(mode)
  if !exists('g:ale_buffer_info')
    return ''
  endif

  let l:buffer = bufnr('%')
  let [l:error_count, l:warning_count] = ale#statusline#Count(l:buffer)
  let [l:error_format, l:warning_format, l:no_errors] = g:ale_statusline_format

  if a:mode == 0 " Error
    return l:error_count ? printf(l:error_format, l:error_count) : ''
  elseif a:mode == 1 " Warning
    return l:warning_count ? printf(l:warning_format, l:warning_count) : ''
  endif

  return l:error_count == 0 && l:warning_count == 0 ? l:no_errors : ''
endfunction
