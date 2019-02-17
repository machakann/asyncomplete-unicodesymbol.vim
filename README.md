vim-asyncomplete-unicodesymbol.vim
==================================

This is a completion source for [asyncomplete.vim](https://github.com/prabirshrestha/asyncomplete.vim) to convert a LaTeX-like sequence to a unicode symbol; for example `\alpha` to `α`.

## Requirement

 - [julia-vim](https://github.com/JuliaEditorSupport/julia-vim)

## Usage

Add lines into your vimrc.

```vim
autocmd User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#unicodesymbol#get_source_options({
  \ 'name': 'unicodesymbol',
  \ 'whitelist': ['julia'],
  \ 'completor': function('asyncomplete#sources#unicodesymbol#completor'),
  \ }))
```
