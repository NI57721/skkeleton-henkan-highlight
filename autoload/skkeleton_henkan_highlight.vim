let s:prop_type = 'skkeleton-henkan'
let s:namespace = has('nvim') ? nvim_create_namespace(s:prop_type) : 0

let s:henkan_pos = 0
let s:prev_state = ''

function! skkeleton_henkan_highlight#update() abort
  if g:skkeleton#state.phase =~# '^input' && s:prev_state ==# 'henkan'
    " Clear previous state
    call s:disable_highlight()
  endif

  if (g:skkeleton#state.phase ==# 'input' && mode() !=# 'i')
        \ || g:skkeleton#state.phase !~# '^input:\|^henkan'
    call s:disable_highlight()
  else
    call s:enable_highlight(
          \    g:skkeleton#state.phase ==# 'henkan'
          \  ? 'SkkeletonHenkanSelect'
          \  : 'SkkeletonHenkan'
          \ )
  endif

  let s:prev_state = g:skkeleton#state.phase
endfunction

function! s:enable_highlight(highlight_name) abort
  if !hlexists(a:highlight_name) || g:skkeleton#state.henkanFeed ==# ""
    return
  endif

  if g:skkeleton#state.phase ==# 'henkan'
        \ || g:skkeleton#state.phase ==# 'input:okuriari'
    if s:henkan_pos <= 0
      return
    endif

    " Use the last henkan_pos
    let start = s:henkan_pos
  else
    let start = col('.') - len(g:skkeleton#state.henkanFeed)

    " Save henkan_pos
    let s:henkan_pos = start
  endif

  let end = col('.')
  let line = line('.')

  if has('nvim')
    call nvim_buf_set_extmark(0, s:namespace, line - 1, start - 1, #{
          \   end_col: end - 1,
          \   hl_group: a:highlight_name,
          \ })
  else
    if empty(prop_type_get(s:prop_type))
      call prop_type_add(s:prop_type, #{highlight: a:highlight_name})
    else
      call prop_type_change(s:prop_type, #{highlight: a:highlight_name})
    endif

    call prop_add(
          \   line,
          \   start,
          \   #{
          \     end_col: end,
          \     type: s:prop_type,
          \   }
          \ )
  endif

  augroup skkeleton-henkan-highlight-disable
    autocmd!
    autocmd ModeChanged <buffer>
          \ if mode() ==# 'n' |
          \   call s:disable_highlight() |
          \ endif
  augroup END
endfunction

function! s:disable_highlight() abort
  let s:henkan_pos = 0

  if has('nvim')
    call nvim_buf_clear_namespace(0, s:namespace, 0, -1)
  else
    if empty(prop_type_get(s:prop_type))
          \ || empty(prop_find(#{type: s:prop_type}))
      return
    endif

    call prop_clear(1, line('$') + 1, #{type: s:prop_type})
  endif

  augroup skkeleton-henkan-highlight-disable
    autocmd!
  augroup END
endfunction
