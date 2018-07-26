" =============================================================================
" Filename: autoload/lightline/delphinus/components.vim
" Author: delphinus
" License: MIT License
" Last Change: 2018-07-26T21:52:42+0900.
" =============================================================================

scriptencoding utf-8

if g:lightline_delphinus_use_nerd_fonts_glyphs
  let s:mo_glyph = "\uf040 " " 
  let s:help_glyph = "\uf128" " 
  let s:ale_linting_glyph = " \uf250  " " 
else
  let s:mo_glyph = '+'
  let s:help_glyph = '?'
  let s:ale_linting_glyph = '....'
endif

if g:lightline_delphinus_use_powerline_glyphs
  let s:ro_glyph = "\ue0a2" " 
else
  let s:ro_glyph = 'RO'
endif

function! lightline#delphinus#components#modified() abort
  return &buftype ==# 'terminal' ? '' :
        \ &filetype =~# 'help\|vimfiler\|gundo\|tagbar' ? '' :
        \ &modified ? s:mo_glyph : &modifiable ? '' :
        \ '-'
endfunction

function! lightline#delphinus#components#readonly() abort
  return &buftype ==# 'terminal' ? '' :
        \ &filetype ==# 'help' ? s:help_glyph :
        \ &filetype !~# 'vimfiler\|gundo\|tagbar' && &readonly ? s:ro_glyph :
        \ ''
endfunction

function! lightline#delphinus#components#filepath() abort
  if &buftype ==# 'terminal' || &filetype ==# 'tagbar'
    return ''
  endif
  if &filetype ==# 'denite'
    let ctx = get(b:, 'denite_context', {})
    return get(ctx, 'sorters', '')
  endif
  let ro_string = '' !=# lightline#delphinus#components#readonly() ? lightline#delphinus#components#readonly() . ' ' : ''
  if &filetype ==# 'vimfilter' || &filetype ==# 'unite' || winwidth(0) < 70
    let path_string = ''
  else
    let path_string = substitute(expand('%:h'), $HOME, '~', '')
    if winwidth(0) < 120 && len(path_string) > 30
      let path_string = substitute(path_string, '\v([^/])[^/]*%(/)@=', '\1', 'g')
    endif
  endif

  return ro_string . path_string
endfunction

function! lightline#delphinus#components#filename() abort
  return (&buftype ==# 'terminal' ? has('nvim') ? b:term_title . ' (' . b:terminal_job_pid . ')' : '' :
        \ &filetype ==# 'vimfiler' ? vimfiler#get_status_string() :
        \ &filetype ==# 'unite' ? unite#get_status_string() :
        \ &filetype ==# 'denite' ? denite#get_status_sources() :
        \ &filetype ==# 'tagbar' ? get(g:lightline, 'fname', '') :
        \ '' !=# expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' !=# lightline#delphinus#components#modified() ? ' ' . lightline#delphinus#components#modified() : '')
endfunction

function! lightline#delphinus#components#fugitive() abort
  if &buftype ==# 'terminal' || winwidth(0) < 100
    return ''
  endif
  try
    if &filetype !~? 'vimfiler\|gundo\|denite\|tagbar' && exists('*fugitive#head')
      return fugitive#head()
    endif
  catch
  endtry
  return ''
endfunction

function! lightline#delphinus#components#fileformat() abort
  return &buftype ==# 'terminal' || &filetype =~# 'denite\|tagbar' ? '' :
        \ winwidth(0) > 120 ? &fileformat . (exists('*WebDevIconsGetFileFormatSymbol') ? ' ' . WebDevIconsGetFileFormatSymbol() : '') : ''
endfunction

function! lightline#delphinus#components#filetype() abort
  return &buftype ==# 'terminal' || &filetype ==# 'tagbar' ? '' :
        \ &filetype ==# 'denite' ? denite#get_status('is_async') ? '[async]' : '' :
        \ winwidth(0) > 120 ? (strlen(&filetype) ? &filetype . (exists('*WebDevIconsGetFileTypeSymbol') ? ' ' . WebDevIconsGetFileTypeSymbol() : '') : 'no ft') : ''
endfunction

function! lightline#delphinus#components#fileencoding() abort
  return &buftype ==# 'terminal' || &filetype =~# 'denite\|tagbar' ? '' :
        \ winwidth(0) > 120 ? (strlen(&fileencoding) ? &fileencoding : &encoding) : ''
endfunction

function! lightline#delphinus#components#mode() abort
  if &filetype ==# 'denite'
    let mode = denite#get_status('raw_mode')
    call lightline#link(tolower(mode[0]))
    return 'Denite'
  endif
  let fname = expand('%:t')
  return fname =~# 'unite' ? 'Unite' :
        \ fname =~# 'vimfiler' ? 'VimFilter' :
        \ fname =~# '__Gundo__' ? 'Gundo' :
        \ &filetype ==# 'tagbar' ? 'Tagbar' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! lightline#delphinus#components#charcode() abort
  if &buftype ==# 'terminal' || &filetype =~# 'denite\|tagbar'
    return ''
  endif
  if winwidth(0) <= 120
    return ''
  endif
  " if char on cursor is `Λ̊`, :ascii returns below.
  " <Λ> 923, 16進数 039b, 8進数 1633 < ̊> 778, 16進数 030a, 8進数 1412
  redir => tmp | silent! ascii | redir END
  let chars = []
  call substitute(tmp, '<.>\s\+\d\+,\s\+\S\+ \x\+,\s\+\S\+ \d\+', '\=add(chars, submatch(0))', 'g')
  if len(chars) == 0
    return ''
  endif
  let ascii = []
  for c in chars
    let m = matchlist(c, '<\(.\)>\s\+\d\+,\s\+\S\+ \(\x\+\)')
    if len(m) > 0
      call add(ascii, printf('%s %s', m[1], m[2]))
    endif
  endfor
  return join(ascii, ', ')
endfunction

let s:ale_linting = 0

function! lightline#delphinus#components#ale_pre() abort
  let s:ale_linting = 1
  call lightline#update()
endfunction

function! lightline#delphinus#components#ale_post() abort
  let s:ale_linting = 0
  call lightline#update()
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
  if !exists('g:ale_buffer_info') || &buftype ==# 'terminal' || &filetype =~# 'denite\|tagbar'
    return ''
  endif
  if s:ale_linting
    " it shows an icon in linting with the `warning` color.
    return a:mode == 1 ? s:ale_linting_glyph : ''
  endif

  let buffer = bufnr('%')
  let counts = ale#statusline#Count(buffer)
  let [error_format, warning_format, no_errors] = g:ale_statusline_format

  if a:mode == 0 " Error
    let errors = counts.error + counts.style_error
    return errors ? printf(error_format, errors) : ''
  elseif a:mode == 1 " Warning
    let warnings = counts.warning + counts.style_warning
    return warnings ? printf(warning_format, warnings) : ''
  endif

  return counts.total ? '' : no_errors
endfunction

function! lightline#delphinus#components#lineinfo() abort
  return &filetype ==# 'denite' ? denite#get_status_linenr() :
        \ &filetype ==# 'tagbar' ? '' :
        \ printf('%3d:%-2d', line('.'), col('.'))
endfunction

function! lightline#delphinus#components#percent() abort
  if &filetype ==# 'tagbar'
    return ''
  endif
  let line = &filetype ==# 'denite' ? denite#get_status('line_cursor') : line('.')
  let total = &filetype ==# 'denite' ? denite#get_status('line_total') : line('$')
  return total ? printf('%d%%', 100 * line / total) : '0%'
endfunction

function! lightline#delphinus#components#currenttag() abort
  if &buftype ==# 'terminal' || &filetype =~# 'denite\|tagbar'
    return ''
  endif
  if !get(s:, 'currenttag_init')
    try
      let tmp = tagbar#currenttag('%', '', '')
    catch
    endtry
    unlet! tmp
    let s:currenttag_init = 1
  endif
  if !exists('*tagbar#currenttag')
    return ''
  endif
  let now = localtime()
  if get(s:, 'currenttag_last_lookup') != now
    let s:currenttag_last_lookup = now
    let s:currenttag_last_seen = tagbar#currenttag('%s', '')
  endif
  return get(s:, 'currenttag_last_seen', '')
endfunction

function! lightline#delphinus#components#tagbar_status(current, sort, fname, ...) abort
  let g:lightline.fname = a:fname
  return lightline#statusline(0)
endfunction
