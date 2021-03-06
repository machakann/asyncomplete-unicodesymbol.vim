function! asyncomplete#sources#unicodesymbol#get_source_options(opt) abort
    return extend(a:opt, {'refresh_pattern': '\\$'})
endfunction


function! asyncomplete#sources#unicodesymbol#completor(opt, ctx) abort
    if !exists('s:symbols')
        let s:symbols = s:make_dictionary()
        call asyncomplete#log('cached symbols')
    endif
    let l:typed = a:ctx['typed']
    let [l:matched, l:startcol, _] = matchstrpos(l:typed, '\m\\\%(\k\+\|[_^:].\?\)$')
    if l:startcol < 0 || l:matched is# ''
        return
    endif

    let l:index = strcharpart(l:matched, 0, 2)
    let l:symbols = get(s:symbols, l:index, [])
    if empty(l:symbols)
        return
    endif

    call asyncomplete#complete(a:opt['name'], a:ctx, l:startcol + 1, l:symbols)
endfunction


function! s:make_dictionary() abort
    let symbollist = map(sort(items(julia_latex_symbols#get_dict())),
                       \ '{"word": v:val[1], "menu": v:val[0]}')
    let dict = {}
    for item in symbollist
        let index = strcharpart(item.menu, 0, 2)
        if !has_key(dict, index)
            let dict[index] = []
        endif
        call add(dict[index], item)
    endfor
    return dict
endfunction


function! s:escape(string) abort
    return escape(a:string, '~"\.^$[]*')
endfunction

" vim:set ts=4 sts=4 sw=4 tw=0:
