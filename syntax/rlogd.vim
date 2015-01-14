" Vim Syntax file
" Language:   rlogd
" Maintainer: Kazuya Yokogawa <yokogawa-k@klab.com>
" Version:    0.0.1

scriptencoding utf-8

if exists("b:current_syntax")
    finish
endif

let s:cpo_save = &cpo
set cpo&vim

syntax spell toplevel
"syn case ignore

syn match rlogdComment +#.*+

" mark illegal charcters
syn match rlogdError "[<>&]"

" Directives
syn region rlogdDirectiveEnd             start=+</+ end=+>+ contains=rlogdDirectiveN,rlogdDirectiveError
syn region rlogdDirective                start=+<+  end=+>+ contains=rlogdDirectiveN,rlogdDirectiveError
syn match  rlogdDirectiveN     contained +<[a-z]\++hs=s+1   contains=rlogdDirectiveName
syn match  rlogdDirectiveN     contained +</[a-z]\++hs=s+2  contains=rlogdDirectiveName
syn match  rlogdDirectiveError contained "[^>]<"ms=s+1

" Directive Names
syn keyword rlogdDirectiveName contained source match label

syn keyword rlogdInputOptions type bind label add_prefix add_suffix
syn keyword rlogdOutputOptions type path target buffer_path stdout
syn keyword rlogdInputType forward 
syn keyword rlogdoutputType forward file

hi def link rlogdComment        Comment
hi def link rlogdDirective      Function
hi def link rlogdDirectiveEnd   Identifier
hi def link rlogdDirectiveName  Statement
hi def link rlogdError          Error 
hi def link rlogdDirectiveError Error 
hi def link rlogdInputOptions   String
hi def link rlogdOutputOptions  String
hi def link rlogdInputType      String
hi def link rlogdOutputOptions  String

let b:current_syntax = 'rlogd'

let &cpo = s:cpo_save
unlet s:cpo_save

" vim: ts=4 sw=4 sts=0 et:
