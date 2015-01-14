" Vim Indent file
" Language:   rlogd
" Maintainer: Kazuya Yokogawa <yokogawa-k@klab.com>
" Version:    0.0.1


" Only load this indent file when no other was loaded.
if exists("b:did_indent")
    finish
endif

setlocal indentexpr=GetRlogdIndent()

if exists('*GetRlogdIndent')
  finish
endif

let s:cpo_save= &cpo
set cpo&vim

setlocal indentkeys=o,O,*<Return>,<>>,<<>,/,{,}

if !exists('b:rlogd_indent_open')
    let b:rlogd_indent_open = '.\{-}<\a'
endif

if !exists('b:rlogd_indent_close')
    let b:rlogd_indent_close = '.\{-}</'
endif

function! s:rlogdIndentWithPattern(line, pat)
    let s = substitute('x'.a:line, a:pat, "\1", 'g')
    return strlen(substitute(s, "[^\1].*$", '', ''))
endfun

function! s:rlogdIndentSynCheck(lnum)
    " check in comments?
    if '' != &syntax
        let syn1 = synIDattr(synID(a:lnum, 1, 1), 'name')
        let syn2 = synIDattr(synID(a:lnum, strlen(getline(a:lnum)) - 1, 1), 'name')
        if syn1 =~ '^rlogdComment' && syn2 =~ '^rlogdComment'
            return -1
        endif
    endif
    return 1
endfun

function! s:rlogdIndentSum(lnum, style, add)
    let line = getline(a:lnum)
    if a:style == match(line, '^\s*</')
        return (&sw *
                    \  (s:rlogdIndentWithPattern(line, b:rlogd_indent_open)
                    \ - s:rlogdIndentWithPattern(line, b:rlogd_indent_close)
                    \ - s:rlogdIndentWithPattern(line, '.\{-}/>'))) + a:add
    else
        return a:add
    endif
endfun

function! GetRlogdIndent()
    let lnum = prevnonblank(v:lnum - 1)
    if lnum == 0
        return 0
    endif

    " check in comments.
    let check_lnum = s:rlogdIndentSynCheck(lnum)
    let check_alnum = s:rlogdIndentSynCheck(v:lnum)
    if 0 == check_lnum || 0 == check_alnum
        return indent(a:lnum)
    elseif -1 == check_lnum || -1 == check_alnum
        return -1
    endif

    let ind = s:rlogdIndentSum(lnum, -1, indent(lnum))
    let ind = s:rlogdIndentSum(v:lnum, 0, ind)

    return ind
endfun

let b:did_indent = 1
let &cpo = s:cpo_save
unlet s:cpo_save

" vim: ts=4 sw=4 sts=0 et:
