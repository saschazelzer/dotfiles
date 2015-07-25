"============================================================================
"File:        asciidoc.vim
"Description: Syntax checking plugin for syntastic.vim
"Maintainer:  LCD 47 <lcd047 at gmail dot com>
"License:     This program is free software. It comes without any warranty,
"             to the extent permitted by applicable law. You can redistribute
"             it and/or modify it under the terms of the Do What The Fuck You
"             Want To Public License, Version 2, as published by Sam Hocevar.
"             See http://sam.zoy.org/wtfpl/COPYING for more details.
"
"============================================================================

if exists('g:loaded_syntastic_asciidoc_asciidoctor_checker')
    finish
endif
let g:loaded_syntastic_asciidoc_asciidoctor_checker = 1

let s:save_cpo = &cpo
set cpo&vim

function! SyntaxCheckers_asciidoc_asciidoctor_GetLocList() dict
    let makeprg = self.makeprgBuild({ 'exe_after': '-r asciidoctor-diagram', 'args_after': syntastic#c#NullOutput() })

    let errorformat =
        \ '%Easciidoctor: %tRROR: %f: line %l: %m,' .
        \ '%Easciidoctor: %tRROR: %f: %m,' .
        \ '%Easciidoctor: FAILED: %f: line %l: %m,' .
        \ '%Easciidoctor: FAILED: %f: %m,' .
        \ '%Wasciidoctor: %tARNING: %f: line %l: %m,' .
        \ '%Wasciidoctor: %tARNING: %f: %m,' .
        \ '%Wasciidoctor: DEPRECATED: %f: line %l: %m,' .
        \ '%Wasciidoctor: DEPRECATED: %f: %m'

    return SyntasticMake({
        \ 'makeprg': makeprg,
        \ 'errorformat': errorformat,
        \ 'returns': [0, 1] })
endfunction

call g:SyntasticRegistry.CreateAndRegisterChecker({
    \ 'filetype': 'asciidoc',
    \ 'name': 'asciidoctor'})

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: set sw=4 sts=4 et fdm=marker:
