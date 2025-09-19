if exists('g:loaded_skkeleton_henkan_highlight') && g:loaded_skkeleton_henkan_highlight
  finish
endif
let g:loaded_skkeleton_henkan_highlight = v:true

call prop_type_add('skkeleton-henkan', #{highlight: 'SkkeletonHenkan'})

augroup skkeleton-henkan-highlight
  autocmd!
  autocmd User skkeleton-handled,skkeleton-disable-post call s:update()
  autocmd ModeChanged <buffer>
        \ if mode() ==# 'n' |
        \   call s:disable_highlight() |
        \ endif
augroup END

let s:henkan_pos = []

function! s:update() abort
  if g:skkeleton#state.phase !=# 'input' && mode() ==# 'i'
    call s:enable_highlight()
  else
    call s:disable_highlight()
  endif
endfunction

function! s:enable_highlight() abort
  if empty(s:henkan_pos)
    let s:henkan_pos = getpos('.')
  endif

  let col = col('.')
  let line = line('.')

  if s:henkan_pos[1] != line ||
        \ g:skkeleton#state.phase =~# '^input:' && s:henkan_pos[2] == col ||
        \ col <  s:henkan_pos[2]
    return
  endif

  call prop_add(
        \   line,
        \   min([s:henkan_pos[2], col]),
        \   #{
        \     end_col: max([s:henkan_pos[2], col]),
        \     type: 'skkeleton-henkan',
        \   }
        \ )
endfunction

function! s:disable_highlight() abort
  let s:henkan_pos = []
  call prop_remove(#{type: 'skkeleton-henkan'})
endfunction

