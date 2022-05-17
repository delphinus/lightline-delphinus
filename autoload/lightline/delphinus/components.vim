" =============================================================================
" Filename: autoload/lightline/delphinus/components.vim
" Author: delphinus
" License: MIT License
" Last Change: 2020-04-21T18:42:08+0900.
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
  let s:branch_glyph = "\ue0a0" " 
else
  let s:ro_glyph = 'RO'
  let s:branch_glyph = ''
endif

" s:is_using_dein is used for detecting tagbar is enabled
let s:is_using_dein = exists('*dein#is_sourced')

function! lightline#delphinus#components#modified() abort
  return &buftype ==# 'terminal' ? '' :
        \ &filetype =~# 'help\|vimfiler\|gundo\|fzf\|tagbar\|denite' ? '' :
        \ &modified ? s:mo_glyph : &modifiable ? '' :
        \ '-'
endfunction

function! lightline#delphinus#components#readonly() abort
  return &buftype ==# 'terminal' ? '' :
        \ &filetype ==# 'help' ? s:help_glyph :
        \ &filetype !~# 'vimfiler\|gundo\|fzf\|tagbar\|denite' && &readonly ? s:ro_glyph :
        \ ''
endfunction

function! lightline#delphinus#components#filepath() abort
  if &buftype ==# 'terminal' || &filetype ==# 'tagbar' || &filetype ==# 'denite-filter'
    return ''
  endif
  if &filetype ==# 'denite'
    return denite#get_status('input')
  endif
  let ro_glyph = lightline#delphinus#components#readonly()
  let ro_string = '' !=# ro_glyph ? ro_glyph . ' ' : ''
  if get(b:, 'fugitive_type', '') !=# ''
    let fugitive_status = fugitive#statusline()[1:-2] " remove square brackets: [...]
    return ro_string . fugitive_status
  endif
  if &filetype =~# 'vimfilter\|unite\|fzf' || winwidth(0) < 70
    let path_string = ''
  else
    if exists('+shellslash')
      let saved_shellslash = &shellslash
      set shellslash
    endif
    let path_string = substitute(expand('%:h'), fnamemodify(expand($HOME),''), '~', '')
    if winwidth(0) < 120 && len(path_string) > 30
      let path_string = substitute(path_string, '\v([^/])[^/]*%(/)@=', '\1', 'g')
    endif
    if exists('+shellslash')
      let &shellslash = saved_shellslash
    endif
  endif

  return ro_string . path_string
endfunction

function! lightline#delphinus#components#filename() abort
  return (&buftype ==# 'terminal' ? has('nvim') ? b:term_title . ' (' . b:terminal_job_pid . ')' : '' :
        \ &buftype ==# 'quickfix' ? (getwininfo(win_getid())[0].loclist ? '[Location List] ' : '[Quick Fix] ')
        \                                         . get(w:, 'quickfix_title', '') :
        \ &filetype ==# 'vimfiler' ? vimfiler#get_status_string() :
        \ &filetype ==# 'unite' ? unite#get_status_string() :
        \ &filetype ==# 'denite' ? denite#get_status('sources') :
        \ &filetype ==# 'denite-filter' ? '' :
        \ &filetype ==# 'fzf' ? get(g:lightline, 'fname', '') :
        \ &filetype ==# 'tagbar' ? get(g:lightline, 'fname', '') :
        \ '' !=# expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' !=# lightline#delphinus#components#modified() ? ' ' . lightline#delphinus#components#modified() : '')
endfunction

function! lightline#delphinus#components#fugitive() abort
  if &buftype ==# 'terminal' || &filetype =~# 'denite' || winwidth(0) < 100
    return ''
  endif
  try
    if &filetype !~? 'vimfiler\|gundo\|tagbar' && get(g:, 'loaded_fugitive')
      let head = FugitiveHead()
      if head !=? ''
        let head = s:branch_glyph . head
      endif
      return head
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
  return &buftype ==# 'terminal' || &filetype =~# 'denite\|tagbar' ? '' :
        \ winwidth(0) > 120 ? (strlen(&filetype) ? &filetype . (exists('*WebDevIconsGetFileTypeSymbol') ? ' ' . WebDevIconsGetFileTypeSymbol() : '') : 'no ft') : ''
endfunction

function! lightline#delphinus#components#fileencoding() abort
  return &buftype ==# 'terminal' || &filetype =~# 'denite\|tagbar' ? '' :
        \ winwidth(0) > 120 ? (strlen(&fileencoding) ? &fileencoding : &encoding) : ''
endfunction

function! lightline#delphinus#components#mode() abort
  let fname = expand('%:t')
  return fname =~# 'unite' ? 'Unite' :
        \ fname =~# 'vimfiler' ? 'VimFilter' :
        \ fname =~# '__Gundo__' ? 'Gundo' :
        \ fname =~# 'fzf' ? 'FZF' :
        \ &filetype =~# 'denite' ? 'Denite' :
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
  let tmp = ''
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
  if !get(g:, 'loaded_ale') || &buftype ==# 'terminal' || &filetype =~# 'denite\|tagbar'
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
  if &filetype ==# 'denite'
    return printf('%3d/%-2d', line('.'), denite#get_status('line_total'))
  elseif &filetype ==# 'tagbar' || &filetype ==# 'denite-filter'
    return ''
  endif
  let c = col('.')
  let vc = virtcol('.')
  if c != vc
    return printf('%3d:%d-%d', line('.'), c, vc)
  endif
  return printf('%3d:%-2d', line('.'), c)
endfunction

function! lightline#delphinus#components#percent() abort
  if &filetype ==# 'tagbar'
    return ''
  endif
  let total = &filetype ==# 'denite' ? denite#get_status('line_total') : line('$')
  return total ? printf('%d%%', 100 * line('.') / total) : '0%'
endfunction

function! lightline#delphinus#components#currenttag() abort
  if !g:lightline_delphinus_tagbar_enable || !lightline#delphinus#components#is_tagbar_enabled() || &buftype ==# 'terminal' || &filetype =~# 'denite\|tagbar'
    return ''
  endif
  let now = localtime()
  if get(s:, 'currenttag_last_lookup') != now
    let s:currenttag_last_lookup = now
    let s:currenttag_last_seen = tagbar#currenttag('%s', '')
  endif
  return get(s:, 'currenttag_last_seen', '')
endfunction

function! lightline#delphinus#components#is_tagbar_enabled() abort
  return s:is_using_dein ? dein#is_sourced('tagbar') : get(g:, 'loaded_tagbar')
endfunction

function! lightline#delphinus#components#tagbar_status(current, sort, fname, ...) abort
  let g:lightline.fname = a:fname
  return lightline#statusline(0)
endfunction

function! lightline#delphinus#components#gitgutter_pre() abort
  let g:lightline_delphinus_gitgutter_context = get(g:, 'gitgutter_hook_context', {})
  call lightline#update()
endfunction

function! lightline#delphinus#components#gitgutter() abort
  if !g:lightline_delphinus_gitgutter_enable || !get(g:, 'loaded_gitgutter') || &filetype =~# 'gundo\|fzf\|tagbar\|denite' || winwidth(0) < 120
    return ''
  endif
  let ctx = get(g:, 'lightline_delphinus_gitgutter_context', {})
  let nr = get(ctx, 'bufnr', -9999)
  if nr == -9999 || nr != bufnr('%')
    return ''
  endif
  let hunks = gitgutter#hunk#hunks(nr)
  if len(hunks) == 0
    return ''
  endif
  let gitgutter_status = {'added': 0, 'modified': 0, 'removed': 0, 'modified_removed': 0}
  for [line1, num1, line2, num2] in hunks
    if num1 == 0
      let gitgutter_status['added'] += num2
    elseif num1 < num2
      let gitgutter_status['added'] += num2 - num1
      let gitgutter_status['modified'] += num1
    elseif num1 == num2
      let gitgutter_status['modified'] += num1
    elseif num2 == 0
      let gitgutter_status['removed'] += num1
    else
      let gitgutter_status['modified_removed'] += num1 - num2
    endif
  endfor
  return printf('%s %d %s %d %s %d %s %d',
        \ g:gitgutter_sign_added, gitgutter_status['added'],
        \ g:gitgutter_sign_modified, gitgutter_status['modified'],
        \ g:gitgutter_sign_removed, gitgutter_status['removed'],
        \ g:gitgutter_sign_modified_removed, gitgutter_status['modified_removed'])
endfunction

function! lightline#delphinus#components#signify() abort
  if !g:lightline_delphinus_signify_enable || !get(g:, 'loaded_signify') || &filetype =~# 'gundo\|fzf\|tagbar\|denite' || winwidth(0) < 120
    return ''
  endif
  let [added, modified, removed] = sy#repo#get_stats()
  " this means signify does not recognize diffs.
  if added == -1
    return ''
  endif
  return printf('%s %d %s %d %s %d',
        \ g:signify_sign_add, added,
        \ g:signify_sign_change, modified,
        \ g:signify_sign_delete, removed)
endfunction
