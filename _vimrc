set nocompatible

"Highlight current line"
au WinLeave * set nocursorline nocursorcolumn
au WinEnter * set cursorline "cursorcolumn
set cursorline "cursorcolumn



set backspace=2   " Backspace deletes like most programs in insert mode
set nobackup
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set history=50
"set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands
set confirm       " Need confrimation while exit
set fileencodings=utf-8,gb18030,gbk,big5
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
"myself configuration
:inoremap jk <esc>
let mapleader = ","
:nnoremap <space> <PageDown>
:vnoremap <space> <PageDown>
:nnoremap <tab> <PageUp>
:vnoremap <tab> <PageUp>
:nnoremap <leader><space> <PageUp>
:vnoremap <leader><space> <PageUp>
:nnoremap <leader>c mpgg4jv$G"+y`pzz
:nnoremap <leader>= mpggvG=`pzz
:nnoremap <leader>n :set number!<cr>
:nnoremap <leader>p viwp
:nnoremap <M-left>  :bn <cr>
set relativenumber
set number
set backspace=2
set tabstop=4 "制表符的宽度
set softtabstop=4
set shiftwidth=4 "缩进的空格
set autoindent "自动缩进
set nohlsearch "设置行号
set wrap "一行就一行别弄到第二行去
set smartindent "开启只能自动缩进
filetype plugin indent on "自动识别文件类型,用文件类型plugin脚本
hi CursorLine term=bold cterm=bold guibg=Grey40

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif



"if you want to use bundle the the follow line is necessary
filetype off
" 此处规定Vundle的路径  
set rtp+=$VIM/vimfiles/bundle/vundle/  
call vundle#rc('$VIM/vimfiles/bundle/')  
Bundle 'gmarik/vundle'  
filetype plugin indent on 


"auto complete plugin, comment on windows
"Bundle 'Valloric/YouCompleteMe'
"and its config

Bundle "Lokaltog/vim-powerline"
"vim-poerline comfig
set laststatus=2
set t_Co=256
set encoding=utf8

Bundle "tomasr/molokai"
Bundle "klen/python-mode"

" 自动补全单引号，双引号等
Bundle 'Raimondi/delimitMate'

" for python docstring ", 特别有用
au FileType python let b:delimitMate_nesting_quotes = ['"']
" 关闭某些类型文件的自动补全
"au FileType mail let b:delimitMate_autoclose = 0


"Bundle 'scrooloose/syntastic'
let g:syntastic_error_symbol='>>'
let g:syntastic_warning_symbol='>'
let g:syntastic_check_on_open=1
let g:syntastic_check_on_wq=0
let g:syntastic_enable_highlighting=1
let g:syntastic_python_checkers=['pyflakes'] " 使用pyflakes,速度比pylint快
let g:syntastic_javascript_checkers = ['jsl', 'jshint']
let g:syntastic_html_checkers=['tidy', 'jshint']
"选择了待选的文字之后就会自动关闭 scratch窗口
let g:ycm_autoclose_preview_window_after_insertion = 1  
let g:ycm_autoclose_preview_window_after_completion = 1
" 修改高亮的背景色, 适应主题
highlight SyntasticErrorSign guifg=white guibg=black

":lnext  到下一个错误
":lprevious 到上一个错误

" to see error location list
let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_loc_list_height = 5
function! ToggleErrors()
    let old_last_winnr = winnr('$')
    lclose
    if old_last_winnr == winnr('$')
        " Nothing was closed, open syntastic error location panel
        Errors
    endif
endfunction
nnoremap <Leader>s :call ToggleErrors()<cr>
" nnoremap <Leader>sn :lnext<cr>
" nnoremap <Leader>sp :lprevious<cr>

"自动添加注释的插件
Bundle 'scrooloose/nerdcommenter'
"下面的这些都是默认的配置
"<leader>cc   加注释
"<leader>cu   解开注释

"<leader>c<space>  加上/解开注释, 智能判断
"<leader>cy   先复制, 再注解(p可以进行黏贴)

"模糊打开文件
Bundle 'ctrlpvim/ctrlp.vim'
let g:ctrlp_map = '<c-p>' "模糊搜索当前目录及其子目录下的所有文件
let g:ctrlp_cmd = 'CtrlP'
"模糊搜索最近打开的文件
map <leader>f :CtrlPMRU<CR>   
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn|rvm)$',
    \ 'file': '\v\.(exe|so|dll|zip|tar|tar.gz|pyc)$',
    \ }
let g:ctrlp_working_path_mode=0
let g:ctrlp_match_window_bottom=1
let g:ctrlp_max_height=15
let g:ctrlp_match_window_reversed=0
let g:ctrlp_mruf_max=500
let g:ctrlp_follow_symlinks=1


""模糊函数搜索
"Bundle 'tacahiroy/ctrlp-funky'
"nnoremap <c-i> :CtrlPFunky<Cr>
"" narrow the list down with a word under cursor
"let g:ctrlp_funky_syntax_highlight = 1
"let g:ctrlp_extensions = ['funky']

"Removes the menubar.
:set guioptions -=m 
"Removes the toolbar.
:set guioptions -=T
"设置字体
:set guifont=Consolas:h11

"一定要放在这里,要不然不能够变色
:syntax on
colorscheme molokai
