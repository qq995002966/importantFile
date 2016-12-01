set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

set diffexpr=MyDiff()
function! MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

set lines=22
winpos 600 200

set relativenumber

"from there is my own configuration
let mapleader = ","	"set mapleader
:inoremap jk <esc>	"map jk to <esc> key
:nnoremap <leader>n :set number!<cr>	"map <leader>N to toggle number
:nnoremap <leader>a A
:colorscheme molokai	"set colorscheme
syntax enable		"enabel syntax
syntax on
set guifont=consolas:h11
set tags=tags;		"set tags enale
set autochdir

set nobackup
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287

let Tlist_Show_One_File = 1		"Tlist configuration
let Tlist_exit_OnlyWindows = 1

let g:winManagerWindowLayout = 'FileExplorer|TagList'	"WindowManager Configuration
:nmap <leader>w :WMToggle<cr>

let g:miniBufExplMapCTabSwithBufs = 1		"nimiBufExpl Configuration
let g:miniBufExplMapWindowsNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1

"set encoding = utf-8 			"resovle chinese garbled 
"set termencoding = utf-8		"but through test, after add such code
"set fileencodings = utf-8,chinese,lantin-1		"the chinese will
"if has("win32")		"become garbled,so I decide to annotate it
"	set fileencoding = chinese
"else
"	set fileencoding = utf-8
"endif
"language messages zh_CN.utf-8
""""""""""""""""""""""""""""""""""""""""""
:"from here on,I copy it form ubuntu ~/.vimrc
:set cul		"highlight current line
:set shortmess =atI
:set go =
:set ruler
:set showcmd
:set scrolloff=5
:set autoindent
:set cindent
:set tabstop=4
:set softtabstop=4
:set shiftwidth=4
:filetype on
:filetype plugin on
:filetype indent on
:set viminfo+=!
:set iskeyword+=_,$,@,%,#,-
:set tw=0
:"add some my KEYMAP
imap <c-u> <esc>mjbveU`j:delmarks j<cr>a
:nnoremap <Space> <PageDown>
:nnoremap <leader><Space> <PageUp>
:nnoremap <leader>ev :vsplit $MYVIMRC<cr>
:nnoremap <leader>sv :source $MYVIMRC<cr>
:nnoremap <esc> :noh<esc>
:nnoremap ci, :call ChangeInComma()<cr>
func! ChangeInComma()
	if getline(".")[col(".")-1]==','
		exec "normal l"
	endif

	exec "normal! F,dt,i,\<esc>a"
endfunc
"that's,123,456,789
nnoremap <kPlus> <C-a>
nnoremap <kMinus> <C-x>
"
:imap -" """"""""""""""""""""""""""""""""""""<esc>o
:imap -// /////////////////////////////////////////////<esc>o

:inoremap <c-p> <esc>mj0i//<esc>`j<esc>:delmarks j<cr>lla
:nnoremap -/ mj0i//<esc>`j<esc>ll
:nnoremap <leader>w <c-w>
:nnoremap <leader>c :call ChangeAWord()<cr>
func! ChangeAWord()
	if getline(".")[col(".")-1]==' '
		exec "normal! hcaw "
	endif
		exec "normal! caw"
endfunc
"test ChangeAWord 
autocmd BufNewFile *.cpp,*.[ch],*.sh,*.rb,*.java,*.py exec ":call SetTitle()"
function! SetTitle()
	if &filetype == 'sh'
		call setline(1,"#!/bin/bash")
		call append(line(".","")
	elseif &filetype == 'python'
		call setline(1,"#!/usr/bin/env python")
		call append(line("."),"# coding=utf-8")
		call append(line(".")+1,"")
	elseif &filetype == 'ruby'
		call setline(1,"#!/usr/bin/env ruby")
		call append(line("."),"# encoding: utf-8")
		call append(line(".")+1,"")
    else 
        call setline(1, "/*************************************************************************") 
        call append(line("."), "	> File Name: ".expand("%")) 
        call append(line(".")+1, "	> Author: ") 
        call append(line(".")+2, "	> Mail: ") 
        call append(line(".")+3, "	> Created Time: ".strftime("%c")) 
        call append(line(".")+4, " ************************************************************************/") 
        call append(line(".")+5, "")
    endif
    if expand("%:e") == 'cpp'
        call append(line(".")+6, "#include<iostream>")
        call append(line(".")+7, "using namespace std;")
        call append(line(".")+8, "")
    endif
    if &filetype == 'c'
        call append(line(".")+6, "#include<stdio.h>")
        call append(line(".")+7, "")
    endif
    if expand("%:e") == 'h'
        call append(line(".")+6, "#ifndef _".toupper(expand("%:r"))."_H")
        call append(line(".")+7, "#define _".toupper(expand("%:r"))."_H")
        call append(line(".")+8, "#endif")
    endif
    if &filetype == 'java'
        call append(line(".")+6,"public class ".expand("%:r"))
        call append(line(".")+7,"")
    endif
    "新建文件后，自动定位到文件末尾
endfunc 
autocmd BufNewFile * normal G

"C，C++ 按F5编译运行
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
	echo "CompileRunGcc"
    exec "w"
    if &filetype == 'c'
        exec "!g++ % -o %<"
        exec "! ./%<"
    elseif &filetype == 'cpp'
        exec "!g++ % -o %<"
        exec "! ./%<"
    elseif &filetype == 'java' 
        exec "!javac %" 
        exec "!java %<"
    elseif &filetype == 'sh'
        :!./%
    endif
endfunc
"C,C++的调试
map <F8> :call Rungdb()<CR>
func! Rungdb()
    exec "w"
    exec "!g++ % -g -o %<"
    exec "!gdb ./%<"
endfunc
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

:nnoremap <silent> <leader>t <esc>:Tlist<RETURN>
:map <c-a> ggvG$"+y
:nnoremap <leader>f gg=G

set autoread
"set eop=preview,menu
set nobackup		
set noswapfile

"use bundle to manage plungins
filetype off  
" 此处规定Vundle的路径  
set rtp+=$VIM/vimfiles/bundle/vundle/  
call vundle#rc('$VIM/vimfiles/bundle/')  
Bundle 'gmarik/vundle'  
filetype plugin indent on 


" Define bundles via Github repos
Bundle 'christoomey/vim-run-interactive'
"Bundle 'Valloric/YouCompleteMe'
Bundle 'croaky/vim-colors-github'
Bundle 'danro/rename.vim'
Bundle 'majutsushi/tagbar'
Bundle 'kchmck/vim-coffee-script'
Bundle 'kien/ctrlp.vim'
Bundle 'pbrisbin/vim-mkdir'
Bundle 'scrooloose/syntastic'
Bundle 'slim-template/vim-slim'
Bundle 'thoughtbot/vim-rspec'
Bundle 'tpope/vim-bundler'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-surround'
Bundle 'vim-ruby/vim-ruby'
Bundle 'vim-scripts/ctags.vim'
Bundle 'vim-scripts/matchit.zip'
Bundle 'vim-scripts/tComment'
Bundle "mattn/emmet-vim"
Bundle "scrooloose/nerdtree"
Bundle "Lokaltog/vim-powerline"
Bundle "godlygeek/tabular"
Bundle "msanders/snipmate.vim"
Bundle "jelera/vim-javascript-syntax"
Bundle "altercation/vim-colors-solarized"
Bundle "othree/html5.vim"
Bundle "xsbeats/vim-blade"
Bundle "Raimondi/delimitMate"
Bundle "groenewege/vim-less"
Bundle "evanmiller/nginx-vim-syntax"
Bundle "Lokaltog/vim-easymotion"
Bundle "tomasr/molokai"
Bundle "klen/python-mode"
"


"
