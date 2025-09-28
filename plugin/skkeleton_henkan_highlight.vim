if get(g:, 'loaded_skkeleton_henkan_highlight', v:false)
  finish
endif
let g:loaded_skkeleton_henkan_highlight = v:true

augroup skkeleton-henkan-highlight-update
  autocmd!
  autocmd User skkeleton-enable-post,skkeleton-handled,skkeleton-disable-post
        \ call skkeleton_henkan_highlight#update()
augroup END
