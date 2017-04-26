" =============================================================================
" Filename: autoload/lightline/delphinus/components.vim
" Author: delphinus
" License: MIT License
" Last Change: 2017-04-27T08:48:19+0900.
" =============================================================================

scriptencoding utf-8

if g:lightline_delphinus_use_nerd_fonts_glyphs
  let s:mo_glyph = ''
  let s:help_glyph = ''
else
  let s:mo_glyph = '+'
  let s:help_glyph = '?'
endif

if g:lightline_delphinus_use_powerline_glyphs
  let s:ro_glyph = ''
else
  let s:ro_glyph = 'RO'
endif

function! lightline#delphinus#components#modified() abort
  return &filetype =~# 'help\|vimfiler\|gundo' ? '' :
        \ &modified ? s:mo_glyph : &modifiable ? '' :
        \ '-'
endfunction

function! lightline#delphinus#components#readonly() abort
  return &filetype ==# 'help' ? s:help_glyph :
        \ &filetype !~# 'vimfiler\|gundo' && &readonly ? s:ro_glyph :
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
  " if char on cursor is `Λ̊`, :ascii returns below.
  " <Λ> 923, 16進数 039b, 8進数 1633 < ̊> 778, 16進数 030a, 8進数 1412
  redir => l:tmp | silent! ascii | redir END
  let l:chars = []
  call substitute(l:tmp, '<.>\s\+\d\+,\s\+\S\+ \x\+,\s\+\S\+ \d\+', '\=add(l:chars, submatch(0))', 'g')
  if len(l:chars) == 0
    return ''
  endif
  let l:ascii = []
  for l:c in l:chars
    let l:m = matchlist(l:c, '<\(.\)>\s\+\d\+,\s\+\S\+ \(\x\+\)')
    if len(l:m) > 0
      call add(l:ascii, printf('%s %s', l:m[1], l:m[2]))
    endif
  endfor
  return join(l:ascii, ', ')
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
