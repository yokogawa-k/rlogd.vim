" Vim filetype plugin file
" Language:   rlogd
" Maintainer: Kazuya Yokogawa <yokogawa-k@klab.com>
" Version:    0.0.1

if exists("b:did_ftplugin")
    finish
endif
let b:did_ftplugin = 1

let s:cpo_save = &cpo
set cpo-=C

setlocal matchpairs+=<:>

let b:undo_ftplugin = "setlocal matchpairs<"

let &cpo = s:cpo_save
unlet s:cpo_save

" vim: ts=4 sw=4 sts=0 et:
