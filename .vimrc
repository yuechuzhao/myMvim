set nocompatible
source $VIMRUNTIME/vimrc_example.vim
"
" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2011 Apr 15
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

set nobackup		" do not keep a backup file, use versions instead

set history=1000		" keep 1000 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" Configuration file for vim


" Normally we use vim-extensions. If you want true vi-compatibility
" remove change the following statements
set backspace=1		" more powerful backspacing
set backspace=eol,start,indent

" 默认4个空格
set softtabstop=4   " 统一缩进为4  
set sw=4            " 自动缩进的时候， 缩进尺寸为 4 个空格。   
set ts=4            " Tab 宽度为 4 个字符。  
set expandtab
set wildmenu
set smarttab
" Popup a window showing all matching command above command line when autocomplete.
autocmd FileType python setlocal et sta sw=4 sts=4

set number

"强迫自己用 hjkl
map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>

" Don't write backup file if vim is being called by "crontab -e"
au BufWrite /private/tmp/crontab.* set nowritebackup
" Don't write backup file if vim is being called by "chpass"
au BufWrite /private/etc/pw.* set nowritebackup
filetype off                   " required!  
  
set rtp+=~/.vim/bundle/vundle/  
call vundle#rc()  
" let Vundle manage Vundle  
" required!   
"这是vundle本身的设置  
Bundle 'gmarik/vundle'  

" vim-scripts repos，vim-scripts的访问地址，格式则如下：  
"
Bundle 'L9'  
Bundle 'Lokaltog/powerline'
Bundle 'neosnippet'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'Tagbar'
Bundle 'ctrlp.vim'
Bundle "pangloss/vim-javascript"

Bundle 'Markdown'
"主题
Bundle 'Zenburn'
Bundle 'altercation/vim-colors-solarized'
Bundle 'jellybeans.vim'
Bundle 'hybrid.vim'
Bundle 'jsbeautify'
" 自动完成
Bundle 'Valloric/YouCompleteMe'

"自动补全单引号，双引号等
Bundle 'Raimondi/delimitMate'

" non github repos ，非git的访问地址的，格式如下：  
Bundle 'git://git.wincent.com/command-t.git'  

Bundle 'JSON.vim'

filetype plugin indent on     " required! 
"  
" Brief help  
" :BundleList          - list configured bundles  
" :BundleInstall(!)    - install(update) bundles  
" :BundleSearch(!) foo - search(or refresh cache first) for foo  
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles  
"  
" see :h vundle for more details or wiki for FAQ  
" NOTE: comments after Bundle command are not allowed..  

set rtp+=/Users/orca/.vim/bundle/powerline/powerline/bindings/vim
set laststatus=2
set noshowmode

" 用空格键来开关折叠
set foldenable
set foldlevel=0
set foldmethod=indent
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>

"window
if(has("win32") || has("win95") || has("win64") || has("win16"))
    let g:iswindows=1
else
    let g:iswindows=0
endif
autocmd BufEnter * lcd %:p:h

"tagslist
map <F4> :call Do_CsTag()<CR>
nmap <C-@>s :cs find s <C-R>=expand("<cword>")<CR><CR>:copen<CR>
nmap <C-@>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>c :cs find c <C-R>=expand("<cword>")<CR><CR>:copen<CR>
nmap <C-@>t :cs find t <C-R>=expand("<cword>")<CR><CR>:copen<CR>
nmap <C-@>e :cs find e <C-R>=expand("<cword>")<CR><CR>:copen<CR>
nmap <C-@>f :cs find f <C-R>=expand("<cfile>")<CR><CR>:copen<CR>
nmap <C-@>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>:copen<CR>
nmap <C-@>d :cs find d <C-R>=expand("<cword>")<CR><CR>:copen<CR>
function Do_CsTag()
    let dir = getcwd()
    if filereadable("tags")
        if(g:iswindows==1)
            let tagsdeleted=delete(dir."\\"."tags")
        else
            let tagsdeleted=delete("./"."tags")
        endif
        if(tagsdeleted!=0)
            echohl WarningMsg | echo "Fail to do tags! I cannot delete the tags" | echohl None
            return
        endif
    endif
    if has("cscope")
        silent! execute "cs kill -1"
    endif
    if filereadable("cscope.files")
        if(g:iswindows==1)
            let csfilesdeleted=delete(dir."\\"."cscope.files")
        else
            let csfilesdeleted=delete("./"."cscope.files")
        endif
        if(csfilesdeleted!=0)
            echohl WarningMsg | echo "Fail to do cscope! I cannot delete the cscope.files" | echohl None
            return
        endif
    endif
    if filereadable("cscope.out")
        if(g:iswindows==1)
            let csoutdeleted=delete(dir."\\"."cscope.out")
        else
            let csoutdeleted=delete("./"."cscope.out")
        endif
        if(csoutdeleted!=0)
            echohl WarningMsg | echo "Fail to do cscope! I cannot delete the cscope.out" | echohl None
            return
        endif
    endif
    if(executable('ctags'))
        "silent! execute "!ctags -R --c-types=+p --fields=+S *"
        silent! execute "!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q ."
    endif
    if(executable('cscope') && has("cscope") )
        if(g:iswindows!=1)
            silent! execute "!find . -name '*.h' -o -name '*.c' -o -name '*.cpp' -o -name '*.java' -o -name '*.cs' -o -name '*.py' -o -name '*.pys' > cscope.files"
        else
            silent! execute "!dir /s/b *.c,*.cpp,*.h,*.java,*.cs >> cscope.files"
        endif
        silent! execute "!cscope -b"
        execute "normal :"
        if filereadable("cscope.out")
            execute "cs add cscope.out"
        endif
    endif
endfunction

"tagbar
nmap <silent> <F3> :TagbarToggle<CR>
let g:tagbar_ctags_bin = '/usr/local/bin/ctags'
let g:tagbar_width = 28
let g:tagbar_left = 0
autocmd VimEnter * nested :call tagbar#autoopen(1)    "打开vim时自动打开tagbar   

"NERDTree setting
autocmd VimEnter * NERDTree "启动Vim时自动打开nerdtree
map <F5> :NERDTreeToggle<CR>

"ctrlp
noremap <C-W><C-U> :CtrlPMRU<CR>
nnoremap <C-W>u :CtrlPMRU<CR>
nmap <C-P>d :CtrlP 
nmap <C-P>h :CtrlP ~/<CR>

let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$\|.rvm$'
let g:ctrlp_working_path_mode=0
let g:ctrlp_match_window_bottom=1
let g:ctrlp_max_height=15
let g:ctrlp_match_window_reversed=0
let g:ctrlp_mruf_max=500
let g:ctrlp_follow_symlinks=1
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
" 此行设置自动在父目录中搜索带根目录标记的路径，并设置为当前工作目录
let g:ctrlp_working_path_mode = 'ra'
" 此行设置根目录标记为 .crtlp
let g:ctrlp_root_markers = ['.ctrlp']
set wildignore+=*/tmp/*,*.so,*.swp,*.zip

"对NERD_commenter的设置
let NERDShutUp=1
vmap cs <leader>cs<cr>
nmap cs <leader>cs<cr>
vmap cc <leader>cc<cr>
nmap cc <leader>cc<cr>
vmap ca <leader>ca<cr>
nmap ca <leader>ca<cr>
vmap cu <leader>cu<cr>
nmap cu <leader>cu<cr>

nmap <F9> <Esc>:!ctags -R *<CR>

"显示文件结构
"NERDTree plugin
let NERDTreeWinPos = "left" "where NERD tree window is placed on the screen
let NERDTreeWinSize = 28 "size of the NERD tree
let NERDChristmasTree = 1 "beautiful Nerdtree
let NERDTreeShowBookmarks = 1
let NERDTreeShowHidden = 0
let NERDTreeShowLineNumbers = 1
" 使得按tab时打开新窗口
map <Tab> i
"" 收藏文件,这里有空格的
"""cmap bm Bookmark 



"-------------------------------------------------------------------------------  
"           搜索设置  
"-------------------------------------------------------------------------------  
"打开搜索高亮  
set hlsearch  
  
"忽略大小写  
set ignorecase  

"在查找时输入字符过程中就高亮显示匹配点。然后回车跳到该匹配点。  
set incsearch     
  
"设置查找到文件尾部后折返开头或查找到开头后折返尾部。  
set wrapscan  
set nowrap

"c++的自动补全
"set completeopt = menu

"在所有模式下都允许使用鼠标，还可以是n,v,i,c等
set mouse=a  
  
if has("multi_byte")  
    set encoding=utf-8  
    " English messages only  
    "language messages zh_CN.utf-8  
  
    if has('win32')  
        language english  
        let &termencoding=&encoding  
    endif  
  
    set fencs=ucs-bom,utf-8,gbk,cp936,latin1  
    set formatoptions+=mM  
    set nobomb " 不使用 Unicode 签名  
  
    if v:lang =~? '^\(zh\)\|\(ja\)\|\(ko\)'  
        set ambiwidth=double  
    endif  
else  
    echoerr "Sorry, this version of (g)vim was not compiled with +multi_byte"  
endif  
  
" =========  
" 图形界面  
" ========= 
if has('gui_running')  
    " 只显示菜单  
    set guioptions=mcr  
  
    " 高亮光标所在的行  
    set cursorline  
  
    " 编辑器配色  
    "colorscheme jellybeans  
    "colorscheme distinguished  
    "set background=dark
    "colorscheme solarized 
    let g:hybrid_use_Xresources = 1
    colorscheme hybrid

    if has("unix") && !has('gui_macvim')  
        set guifont=Courier\ 16\ Pitch\ 16  
        set guifontwide=YaHei\ Consolas\ Hybrid\ 16  
    endif  
  
    if has("mac") || has("gui_macvim")  
        "set guifont=Courier\ New:h18.00  
        "set guifontwide=YaHei\ Consolas\ Hybrid:h16.00  
        "set guifont=Monaco:h16  
        set guifont=Droid\ Sans\ Mono:h16  
        set guifontwide=Hiragino\ Sans\ GB:h16  
        if has("gui_macvim")  
            "set transparency=4  
            set lines=400 columns=200  
  
            let s:lines=&lines  
            let s:columns=&columns  
            func! FullScreenEnter()  
                set lines=999 columns=999  
                set fu  
            endf  
 
            func! FullScreenLeave()  
                let &lines=s:lines  
                let &columns=s:columns  
                set nofu  
            endf  
  
            func! FullScreenToggle()  
                if &fullscreen  
                    call FullScreenLeave()  
                else  
                    call FullScreenEnter()  
                endif  
            endf  
        endif  
    endif  
endif  

"You completed me
let g:ycm_global_ycm_extra_conf='path'  "在.vimrc中加入这句
  
" 语法
Bundle 'Syntastic'
"Syntastic设置
let g:syntastic_error_symbol='>>'
let g:syntastic_warning_symbol='>'
let g:syntastic_check_on_open=1
let g:syntastic_enable_highlighting = 0
"let g:syntastic_python_checker="flake8,pyflakes,pep8,pylint"
let g:syntastic_python_checkers=['pyflakes']
highlight SyntasticErrorSign guifg=white guibg=black

" python fly check, 弥补syntastic只能打开和保存才检查语法的不足
Bundle 'kevinw/pyflakes-vim'
let g:pyflakes_use_quickfix = 0
let g:syntastic_javascript_checkers=['jshint']
