let s:prop_type = 'skkeleton-henkan'
let s:highlight_name = 'SkkeletonHenkan'
let s:namespace = has('nvim') ? nvim_create_namespace(s:prop_type) : 0

let s:henkan_pos = []

function! skkeleton_henkan_highlight#update() abort
  if (g:skkeleton#state.phase ==# 'input' && mode() !=# 'i')
        \ || g:skkeleton#state.phase !~# '^input:'
    call s:disable_highlight()
  else
    call s:enable_highlight()
  endif
endfunction

function! s:enable_highlight() abort
  if !hlexists(s:highlight_name)
    return
  endif

  if !has('nvim') && empty(prop_type_get(s:prop_type))
    call prop_type_add(s:prop_type, #{highlight: s:highlight_name})
  endif

  if empty(s:henkan_pos)
    let s:henkan_pos = getpos('.')
  endif

  let col = col('.')
  let line = line('.')

  if s:henkan_pos[1] != line ||
        \ g:skkeleton#state.phase =~# '^input:' && s:henkan_pos[2] == col ||
        \ col < s:henkan_pos[2]
    return
  endif

  let start = min([s:henkan_pos[2], col])
  let end = max([s:henkan_pos[2], col])
  if has('nvim')
    call nvim_buf_set_extmark(0, s:namespace, line - 1, start - 1, #{
          \   end_col: end - 1,
          \   hl_group: s:highlight_name,
          \ })
  else
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
  let s:henkan_pos = []

  if has('nvim')
    call nvim_buf_clear_namespace(0, s:namespace, 0, -1)
  else
    if empty(prop_type_get(s:prop_type)) || empty(prop_find(#{type: s:prop_type}))
      return
    endif

    call prop_clear(1, line('$') + 1, #{type: s:prop_type})
  endif

  augroup skkeleton-henkan-highlight-disable
    autocmd!
  augroup END
endfunction
