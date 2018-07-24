"""""""""""""""""""""""""""
"   Zepp's modification   "
"""""""""""""""""""""""""""

" ==> General

set wildmenu "zsh like Tab key view

" Alt key mapping issue
" Also brings another issue: have to wait for a while after <C-[>
"execute "set <M-h>=\eh"
"execute "set <M-l>=\el"

set fileencodings=utf-8,ucs-bom,gbk,cp936,gb18030,gb2312
set encoding=utf-8

" ==> Appearance

set number "line number
set wrap "auto wrap long lines
set linebreak "wrap lines according to spaces

set tabstop=4
set shiftwidth=4

syntax on
colorscheme ron

highlight Comment ctermfg=darkgrey
highlight LineNr ctermfg=darkgrey

" ==> Edit

filetype plugin on
filetype indent on

" Auto read when file changed
set autoread
" :W to sudo saves the file
command W w !sudo tee % > /dev/null
command Q qa

" Moving up and down quicker
set scrolloff=7

" Tab operations
" Ctrl-h/l to switch tab
" n: normal mode; noremap: maps, but not recursively
nnoremap <C-h> gT
nnoremap <C-l> gt
" <CR>: carriage return, means an enter hit
"nnoremap <silent> <C-A-h> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
"nnoremap <silent> <C-A-l> :execute 'silent! tabmove ' . (tabpagenr()+1)<CR>

" ==> Search

set ignorecase "Case insensitive search
set incsearch "Real time search
