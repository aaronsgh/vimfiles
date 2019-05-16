" Author: Aaron Frary <af@aaronfrary.com>

" Are we running Windows or Unix?
if !empty(glob(expand('~/vimfiles/')))
  let s:vimdir=expand('~/vimfiles/')
endif
if !empty(glob(expand('~/.vim/')))
  let s:vimdir=expand('~/.vim/')
endif
" Auto-install vim-plug
if empty(glob(s:vimdir . 'autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

let mapleader = "\<Space>"
let maplocalleader = ","

" Install single threaded for safety, can remove if too slow.
let g:plug_threads=1
call plug#begin()

  " Sensible defaults
  Plug 'aaronsgh/vimrc'

  " Language pack
  Plug 'sheerun/vim-polyglot'

  " Set indentation automatically
  Plug 'tpope/vim-sleuth'

  " Make . command more consistent
  Plug 'tpope/vim-repeat'

  " Improve iTerm2 integration
  Plug 'sjl/vitality.vim'

  " Support for .editorconfig files (https://editorconfig.org)
  Plug 'editorconfig/editorconfig-vim'

  " Show index of matches when searching
  Plug 'vim-scripts/IndexedSearch'

  " Show git diff in left column
  Plug 'airblade/vim-gitgutter'

  " :Ag [options] {pattern} [{directory}]
  " Requires https://github.com/ggreer/the_silver_searcher
  Plug 'rking/ag.vim'

  " To be removed
  Plug 'jlanzarotta/bufexplorer'

  " Improvements to netrw directory browser
  Plug 'tpope/vim-vinegar'

  " To be removed
  Plug 'tpope/vim-fugitive'

  " :Rename {new_filename}
  Plug 'danro/rename.vim'

  " Sets cwd to project root automatically
  Plug 'airblade/vim-rooter'

  " Press v over and over again to expand selection
  Plug 'terryma/vim-expand-region'
  vmap v <Plug>(expand_region_expand)
  vmap V <Plug>(expand_region_shrink)

  " gc<motion> to toggle comments
  Plug 'tpope/vim-commentary'

  " ii / ai motions
  Plug 'michaeljsmith/vim-indent-object'

  " Colorscheme
  Plug 'aaronsgh/mombat.vim'

  " Fancy prompt
  Plug 'bling/vim-airline'
  let g:airline_theme='mombat'
  let g:airline_left_sep=''
  let g:airline_right_sep=''
  if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif
  let g:airline_symbols.crypt='🔒'
  let g:airline_symbols.linenr='¶'
  let g:airline_symbols.branch='⎇'
  let g:airline_symbols.paste='ρ'
  let g:airline_symbols.whitespace='Ξ'
call plug#end()

" Fundamental map: Escape = jj (or jk)
inoremap jj <esc>`^
inoremap jk <esc>`^

" Insert literal tab with Shift + Tab
inoremap <S-Tab> <C-V><Tab>

" <Leader> cancels commands
onoremap <Leader> <Esc>
" <Leader><Leader> is jj for other modes
nnoremap <Leader><Space> <Esc>
vnoremap <Leader><Space> <Esc>

" Clear search hilighting
nnoremap <silent> <Leader>l :nohl<C-L><CR>

" Easy clipboard
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

" Faster navigation of splits
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Toggle Spell checking
nnoremap <Leader>s :setlocal invspell<CR>

" LaTeX Preview (using pdflatex and Skim on MacOS X)
" First command compiles; second opens the pdf.
augroup latex_preview
  autocmd!
  autocmd FileType tex nnoremap <Leader><CR>
        \ :w \| let x=system('pdflatex ' . expand('%:t'))<CR>
  autocmd FileType tex nnoremap <Leader>=
        \ :let x=system('open -a Skim ' . expand('%:r') . '.pdf &')<CR>
augroup END

colorscheme mombat
