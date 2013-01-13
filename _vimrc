"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Get out of VI's compatible mode..
set nocompatible
 
function! MySys()
if has("win32")
return "win32"
elseif has("unix")
return "unix"
else
return "mac"
endif
endfunction
"Set shell to be bash
if MySys() == "unix" || MySys() == "mac"
set shell=bash
else
"I have to run win32 python without cygwin
"set shell=E:cygwininsh
endif
 
"Sets how many lines of history VIM har to remember
set history=400
 
"Enable filetype plugin
filetype on
if has("eval") && v:version>=600
filetype plugin on
filetype indent on
endif
 
"Set to auto read when a file is changed from the outside
if exists("&autoread")
set autoread
endif
 
"Have the mouse enabled all the time:
set mouse=a
 
"Set mapleader
let mapleader = ";"
let g:mapleader = ";"
 
"Fast saving
nmap <leader>w :w!<cr>
 
 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Font
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Enable syntax hl
if MySys()=="unix"
if v:version<600
if filereadable(expand("$VIM/syntax/syntax.vim"))
syntax on
endif
else
syntax on
endif
else
syntax on
endif
 
"if you use vim in tty,
"'uxterm -cjk' or putty with option 'Treat CJK ambiguous characters as wide' on
if exists("&ambiwidth")
set ambiwidth=double
endif
 
if has("gui_running")
"set guioptions-=m
"set guioptions-=T
"set guioptions-=l
"set guioptions-=L
"set guioptions-=r
"set guioptions-=R
"set guioptions+=T
 
if MySys()=="win32"
"使gvim启动时最大化
if has("autocmd")
au GUIEnter * simalt ~x
endif
endif
"let psc_style='cool'
"colorscheme ps_color
"colorscheme default
else
"set background=dark
"colorscheme default
endif
 
"Some nice mapping to switch syntax (useful if one mixes different languages in one file)
map <leader>1 :set syntax=cheetah<cr>
map <leader>2 :set syntax=xhtml<cr>
map <leader>3 :set syntax=python<cr>
map <leader>4 :set ft=javascript<cr>
map <leader>$ :syntax sync fromstart<cr>
 
"Highlight current
if has("gui_running")
if exists("&cursorline")
set cursorline
endif
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Fileformat
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Favorite filetype
set ffs=unix,dos,mac
 
nmap <leader>fd :se ff=dos<cr>
nmap <leader>fu :se ff=unix<cr>
 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM userinterface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Set 7 lines to the curors - when moving vertical..
set so=7
 
"Turn on WiLd menu
set wildmenu

"The commandbar is 2 high
set cmdheight=2
 
"Do not redraw, when running macros.. lazyredraw
set lz
 
"Change buffer - without saving
set hid
 
"Set backspace
set backspace=eol,start,indent
 
"Bbackspace and cursor keys wrap to
set whichwrap+=<,>,h,l
 
"Ignore case when searching
"set ignorecase
set incsearch
 
"Set magic on
set magic
 
"No sound on errors.
set noerrorbells
set novisualbell
set t_vb=
 
"show matching bracet
set showmatch
 
"How many tenths of a second to blink
set mat=4
 
"Highlight search thing
set hlsearch
 
""""""""""""""""""""""""""""""
" => Statusline
""""""""""""""""""""""""""""""
"Format the statusline
" Nice statusbar
set laststatus=2
set statusline=
set statusline+=%2*%-3.3n%0*\ " buffer number
set statusline+=%f\ " file name
set statusline+=%h%1*%m%r%w%0* " flag
set statusline+=[
if v:version >= 600
set statusline+=%{strlen(&ft)?&ft:'none'}, " filetype
set statusline+=%{&encoding}, " encoding
endif
set statusline+=%{&fileformat}] " file format
if filereadable(expand("$VIM/vimfiles/plugin/vimbuddy.vim"))
set statusline+=\ %{VimBuddy()} " vim buddy
endif
set statusline+=%= " right align
set statusline+=%2*0x%-8B\ " current char
set statusline+=%-14.(%l,%c%V%)\ %<%P " offset

"底部状态栏
"highlight StatusLineNC guifg=red guibg=White
set laststatus=2
set statusline=%F%m%r%h%w\ [%{&encoding}][%Y]\[ASCII:%03.3b]\[0x%02.2B]\[%l,%v][%p%%]\[共%L行]
let &termencoding=&encoding
 
" special statusbar for special window
if has("autocmd")
au FileType qf
\ if &buftype == "quickfix" |
\ setlocal statusline=%2*%-3.3n%0* |
\ setlocal statusline+=\ \[Compiler\ Messages\] |
\ setlocal statusline+=%=%2*\ %<%P |
\ endif
 
fun! FixMiniBufExplorerTitle()
if "-MiniBufExplorer-" == bufname("%")
setlocal statusline=%2*%-3.3n%0*
setlocal statusline+=\[Buffers\]
setlocal statusline+=%=%2*\ %<%P
endif
endfun
 
if v:version>=600
au BufWinEnter *
\ let oldwinnr=winnr() |
\ windo call FixMiniBufExplorerTitle() |
\ exec oldwinnr . " wincmd w"
endif
endif
 
" Nice window title
if has('title') && (has('gui_running') || &title)
set titlestring=
set titlestring+=%f\ " file name
set titlestring+=%h%m%r%w " flag
set titlestring+=\ -\ %{v:progname} " program name
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General Autocommand
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Switch to current dir
map <leader>cd :cd %:p:h<cr>
 
 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Parenthesis/bracket expanding
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vnoremap $1 <esc>`>a)<esc>`<i(<esc>
")
vnoremap $2 <esc>`>a]<esc>`<i[<esc>
vnoremap $3 <esc>`>a}<esc>`<i{<esc>
vnoremap $$ <esc>`>a"<esc>`<i"<esc>
vnoremap $q <esc>`>a'<esc>`<i'<esc>
vnoremap $w <esc>`>a"<esc>`<i"<esc>
imap <c-l> <esc>la
imap <c-h> <esc>ha
 
"Map auto complete of (, ", ', [
"http://www.vim.org/tips/tip.php?tip_id=153
"
 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General Abbrev
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Comment for C like language
if has("autocmd")
au BufNewFile,BufRead *.js,*.htc,*.c,*.tmpl,*.css ino $c /**<cr> **/<esc>O
endif
 
"My information
ia xdate <c-r>=strftime("%d/%m/%y %H:%M:%S")<cr>
"iab xname Amir Salihefendic
 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings etc.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Remap VIM 0
map 0 ^
 
"Move a line of text using control
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z
 
if MySys() == "mac"
nmap <D-j> <M-j>
nmap <D-k> <M-k>
vmap <D-j> <M-j>
vmap <D-k> <M-k>
endif
 
 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Command-line config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
func! Cwd()
let cwd = getcwd()
return "e " . cwd
endfunc
 
func! DeleteTillSlash()
let g:cmd = getcmdline()
if MySys() == "unix" || MySys() == "mac"
let g:cmd_edited = substitute(g:cmd, "(.*[/]).*", "", "")
else
let g:cmd_edited = substitute(g:cmd, "(.*[\]).*", "", "")
endif
if g:cmd == g:cmd_edited
if MySys() == "unix" || MySys() == "mac"
let g:cmd_edited = substitute(g:cmd, "(.*[/]).*/", "", "")
else
let g:cmd_edited = substitute(g:cmd, "(.*[\]).*[\]", "", "")
endif
endif
return g:cmd_edited
endfunc
 
func! CurrentFileDir(cmd)
return a:cmd . " " . expand("%:p:h") . "/"
endfunc
 
"cno $q <C->eDeleteTillSlash()<cr>
"cno $c e <C->eCurrentFileDir("e")<cr>
"cno $tc <C->eCurrentFileDir("tabnew")<cr>
cno $th tabnew ~/
cno $td tabnew ~/Desktop/
 
"Bash like
cno <C-A> <Home>
cno <C-E> <End>
cno <C-K> <C-U>
 
 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Buffer realted
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Fast open a buffer by search for a name
"map <c-q> :sb
 
"Open a dummy buffer for paste
map <leader>q :e ~/buffer<cr>
 
"Restore cursor to file position in previous editing session
set viminfo='10,"100,:20,%,n~/.viminfo
 
" Buffer - reverse everything ... :)
map <F9> ggVGg?
 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files and backup
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Turn backup off
set nobackup
set nowb
"set noswapfile
 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Folding
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Enable folding, I find it very useful
if exists("&foldenable")
set fen
endif
 
if exists("&foldlevel")
set fdl=0
endif
 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text option
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" python script
"set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set backspace=2
set smarttab
set lbr
"set tw=500
 
""""""""""""""""""""""""""""""
" => Indent
""""""""""""""""""""""""""""""
"Auto indent
set ai
 
"Smart indet
set si
 
"C-style indenting
set cindent
 
"Wrap line
set wrap
 
 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>sn ]
map <leader>sp [
map <leader>sa zg
map <leader>s? z=
 
 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
 
""""""""""""""""""""""""""""""
" => File explorer
""""""""""""""""""""""""""""""
"Split vertically
let g:explVertical=1
 
"Window size
let g:explWinSize=35
 
let g:explSplitLeft=1
let g:explSplitBelow=1
 
"Hide some file
let g:explHideFiles='^.,.*.class$,.*.swp$,.*.pyc$,.*.swo$,.DS_Store$'
 
"Hide the help thing..
let g:explDetailedHelp=0
 
 
""""""""""""""""""""""""""""""
" => Minibuffer
""""""""""""""""""""""""""""""
let g:miniBufExplModSelTarget = 1
let g:miniBufExplorerMoreThanOne = 0
let g:miniBufExplModSelTarget = 0
let g:miniBufExplUseSingleClick = 1
let g:miniBufExplMapWindowNavVim = 1
"let g:miniBufExplVSplit = 15
let g:miniBufExplSplitBelow=0
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1
 
"WindowZ
map <c-w><c-t> :WMToggle<cr>
 
let g:bufExplorerSortBy = "name"
 
 
""""""""""""""""""""""""""""""
" => Tag list (ctags) - not used
""""""""""""""""""""""""""""""
let Tlist_Ctags_Cmd = "/sw/bin/ctags-exuberant"
"let Tlist_Sort_Type = "name"
"let Tlist_Show_Menu = 1
"map <leader>t :Tlist<cr>
map <F3> :Tlist<cr>
 
 
""""""""""""""""""""""""""""""
" => LaTeX Suite thing
""""""""""""""""""""""""""""""
"set grepprg=grep -r -s -n
let g:Tex_DefaultTargetFormat="pdf"
let g:Tex_ViewRule_pdf='xpdf'
 
if has("autocmd")
"Binding
au BufRead *.tex map <silent><leader><space> :w!<cr> :silent! call Tex_RunLaTeX()<cr>
 
"Auto complete some things ;)
au BufRead *.tex ino <buffer> $i indent
au BufRead *.tex ino <buffer> $* cdot
au BufRead *.tex ino <buffer> $i item
au BufRead *.tex ino <buffer> $m [<cr>]<esc>O
endif
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Todo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"au BufNewFile,BufRead *.todo so ~/vim_local/syntax/amido.vim
 
""""""""""""""""""""""""""""""
" => VIM
""""""""""""""""""""""""""""""
if has("autocmd") && v:version>600
au BufRead,BufNew *.vim map <buffer> <leader><space> :w!<cr>:source %<cr>
endif
 
""""""""""""""""""""""""""""""
" => HTML related
""""""""""""""""""""""""""""""
" HTML entities - used by xml edit plugin
let xml_use_xhtml = 1
"let xml_no_auto_nesting = 1
 
"To HTML
let html_use_css = 0
let html_number_lines = 0
let use_xhtml = 1
 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => MISC
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Remove the Windows ^M
noremap <Leader>m :%s/r//g<CR>
 
"Paste toggle - when pasting something in, don't indent.
"set pastetoggle=<F3>
 
"Remove indenting on empty line
map <F2> :%s/\s*$//g<cr>:noh<cr>''
 
"Super paste
ino <C-v> <esc>:set paste<cr>mui<C-R>+<esc>mv'uV'v=:set nopaste<cr>

set nocompatible    "非兼容模式
syntax on           "开启语法高亮
set background=dark "背景色
color desert
set ruler           "在左下角显示当前文件所在行
set showcmd         "在状态栏显示命令
set showmatch       "显示匹配的括号
set ignorecase      "大小写无关匹配
set smartcase       "只能匹配，即小写全匹配，大小写混合则严格匹配
set hlsearch        "搜索时高亮显示
set incsearch       "增量搜索
"set nohls           "搜索时随着输入立即定位，不知什么原因会关闭结果高亮
set report=0        "显示修改次数
set mouse=a         "控制台启用鼠标
set number          "行号
set nobackup        "无备份
set cursorline      "高亮当前行背景
set fileencodings=ucs-bom,UTF-8,GBK,BIG5,latin1
set fileencoding=UTF-8
set fileformat=unix "换行使用unix方式
set ambiwidth=double
set noerrorbells    "不显示响铃
set visualbell      "可视化铃声
set foldmarker={,}  "缩进符号
set foldmethod=indent   "缩进作为折叠标识
set foldlevel=100   "不自动折叠
set foldopen-=search    "搜索时不打开折叠
set foldopen-=undo  "撤销时不打开折叠
set updatecount=0   "不使用交换文件
set magic           "使用正则时，除了$ . * ^以外的元字符都要加反斜线

" ;hc highlight column
map <leader>hc :call SetColorColumn()<CR>
function! SetColorColumn()
    let col_num = virtcol(".")
    let cc_list = split(&cc, ',')
    if count(cc_list, string(col_num)) <= 0
        execute "set cc+=".col_num
    else
        execute "set cc-=".col_num
    endif
endfunction

"缩进定义
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab
set smarttab
set backspace=2     "退格键可以删除任何东西
"显示TAB字符为<+++
set list
set list listchars=tab:<+

if has("gui_running")
    set lines=25
    set columns=80
    set lazyredraw  "延迟重绘
    set guioptions-=m   "不显示菜单
    set guioptions-=T   "不显示工具栏
    set guifont=consolas\ 10
endif

if has("autocmd")
    "回到上次文件打开所在行
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
        \| exe "normal g'\"" | endif
    "自动检测文件类型，并载入相关的规则文件
    filetype plugin on
    filetype indent on
    "智能缩进，使用4空格，使用全局的了
    "autocmd FileType python setlocal et | setlocal sta | setlocal sw=4
    "autocmd FileType c setlocal et | setlocal sta | setlocal sw=4
    "autocmd FileType h setlocal et | setlocal sta | setlocal sw=4
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => python
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set filetype=python
au BufNewFile,BufRead *.py,*.pyw setf python

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => ctags
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let Tlist_Ctags_Cmd='F:/dev/Vim/vim73/ctags.exe'
set tags=tags; 
set autochdir 

set helplang=cn

filetype plugin on 

set novisualbell
set lines=30 
set columns=118

if has("win32")
    set guifont=Bitstream_Vera_Sans_Mono:h10:cANSI
    "set guifontwide=QingYuan_Mono:h11:cGB2312
endif

" [隐藏|显示]菜单栏 ==> F5
set guioptions-=m " 默认隐藏
set guioptions-=T
map <silent> <F5> :if &guioptions =~# 'T' <Bar>
        \set guioptions-=T <Bar>
        \set guioptions-=m <bar>
    \else <Bar>
        \set guioptions+=T <Bar>
        \set guioptions+=m <Bar>
    \endif<CR>
    
call pathogen#infect()
call pathogen#helptags()

map <F4> :NERDTree<CR>
map <F6> :NERDTreeToggle<CR>
nmap <F8> :TagbarToggle<CR>
"When .vimrc is edited, reload it

""""""""""""""""""""""""""""""
" Tag list (ctags)
""""""""""""""""""""""""""""""
let Tlist_Ctags_Cmd = 'F:/dev/Vim/vim73/ctags.exe'
let Tlist_Show_One_File = 1            "不同时显示多个文件的tag，只显示当前文件的
let Tlist_Exit_OnlyWindow = 1          "如果taglist窗口是最后一个窗口，则退出vim
"let Tlist_Use_Right_Window = 1         "在右侧窗口中显示taglist窗口

" Disable AutoComplPop. 
let g:acp_enableAtStartup = 0 
" Use neocomplcache. 
let g:neocomplcache_enable_at_startup = 1 
" Use smartcase. 
let g:neocomplcache_enable_smart_case = 1 
" Use camel case completion. 
let g:neocomplcache_enable_camel_case_completion = 1 
" Use underbar completion. 
let g:neocomplcache_enable_underbar_completion = 1 
" Set minimum syntax keyword length. 
let g:neocomplcache_min_syntax_length = 3 
let g:neocomplcache_lock_buffer_name_pattern = '*ku*' 
" Define dictionary. 
let g:neocomplcache_dictionary_filetype_lists={'default' : '', 'vimshell' : $HOME.'/.vimshell_hist', 'scheme' : $HOME.'/.gosh_completions'}


" Load rope plugin
let g:pymode_rope = 1
" Auto create and open ropeproject
let g:pymode_rope_auto_project = 1
" Enable autoimport
let g:pymode_rope_enable_autoimport = 1
" Auto generate global cache
let g:pymode_rope_autoimport_generate = 1
let g:pymode_rope_autoimport_generate = 1
let g:pymode_rope_autoimport_underlineds = 0
let g:pymode_rope_codeassist_maxfixes = 10
let g:pymode_rope_sorted_completions = 1
let g:pymode_rope_extended_complete = 1
let g:pymode_rope_autoimport_modules = ["os","shutil","datetime"]
let g:pymode_rope_confirm_saving = 1
let g:pymode_rope_global_prefix = "<C-x>p"
let g:pymode_rope_local_prefix = "<C-c>r"
let g:pymode_rope_vim_completion = 0
let g:pymode_rope_guess_project = 0
let g:pymode_rope_goto_def_newwin = ""
let g:pymode_rope_always_show_complete_menu = 0

let g:pymode_lint = 1
" Switch pylint, pyflakes, pep8, mccabe code-checkers
" Can have multiply values "pep8,pyflakes,mcccabe"
let g:pymode_lint_checker = "pyflakes,pep8,mccabe"


"zc是折叠代码的命令，zo是展开代码,shift+k，查看光标处的函数的文档
" 但是pymode提供的折叠好像有问题，将其禁用，用python_edit.vim代替
let pymode_folding = 0

" django
au FileType python set ft=python.django
au FileType html set ft=htmldjango.html

"显示了python文档并完成选择后，窗口关闭
autocmd CursorMovedI *  if pumvisible() == 0|silent! pclose|endif
autocmd InsertLeave * if pumvisible() == 0|silent! pclose|endif
" 缩进线
let g:indent_guides_guide_size=1 "宽度为1
" 格式化js代码
nnoremap <silent> <leader>js :call g:Jsbeautify()<cr>
" tab转换为4个空格tab to space
map <leader>t2s :%s/<tab>/    /g<cr>

" 光标自动移入括号、引号内部
":inoremap ) ()<Esc>i
":inoremap ( ()<Esc>i
":inoremap { {}<Esc>i
":inoremap } {}<Esc>i
":inoremap [ []<Esc>i
":inoremap ] []<Esc>i
":inoremap < <><Esc>i
":inoremap > <><Esc>i
":inoremap " ""<Esc>i
":inoremap ' ''<Esc>i
":inoremap ` ``<Esc>i

" > <符号缩进
vnoremap < <gv
vnoremap > >gv

set cc=79 " 最大宽度 set colorcolumn=79
set fo+=m " 中文40个字条
set tw=79

" ;ig高亮当前列

" 第79列高亮颜色
highlight ColorColumn guibg=DarkGray
highlight ColorColumn ctermbg=DarkGray


" python_editing.vim 
" F折叠当前文件的Python代码，f折叠光标所在函数（类）的代码
" 初始化折叠所有代码
call ToggleFold()


" ctrlp.vim
" https://github.com/kien/ctrlp.vim.git
" ctrl+p打开文件导航窗口
" 在导航窗口内Ctrl v纵向切分打开，<C-t>新标签打开
" 如果改变了下面的过滤文件名要执行一下:ClearAllCtrlPCaches
noremap <C-W><C-U> :CtrlPMRU<CR>
nnoremap <C-W>u :CtrlPMRU<CR>
let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$\|.rvm$\|\.wsgic$\|\.gif$\|\.png$\|\.jpg$\|\.bmp$\|\.pyc$\|\.pyo$'
"let g:ctrlp_working_path_mode=0
let g:ctrlp_match_window_bottom=1
let g:ctrlp_max_height=15
let g:ctrlp_match_window_reversed=0
let g:ctrlp_mruf_max=500
let g:ctrlp_follow_symlinks=1


" ctags跳转
" <C-]>函数定义处 <C-t>返回 <C-o>

" latex
set shellslash
set grepprg=grep\ -nH\ $*
let g:tex_flavor='latex'

" python
map [r :w <CR>:! python % <CR>
map [o :! python -i % <CR>
map [t :! rst2html.py % %<.html <CR>

" 打开寄存器
map <leader>r :reg<cr>
" pymode默认的<leader>r为运行当前py文件，所以修改一下
let g:pymode_run_key = '<leader>py'

" zencoding
map <leader>z <c-y>,
" powerline 显示绝对全路径
let g:Powerline_stl_path_style = 'full'


" 自动完成[tab]键
" Define keyword. 
if !exists('g:neocomplcache_keyword_patterns') 
    let g:neocomplcache_keyword_patterns = {} 
endif 
let g:neocomplcache_keyword_patterns['default'] = 'hw*' 
" Plugin key-mappings. 
imap <C-k>     <Plug>(neocomplcache_snippets_expand) 
smap <C-k>     <Plug>(neocomplcache_snippets_expand) 
inoremap <expr><C-g>     neocomplcache#undo_completion() 
inoremap <expr><C-l>     neocomplcache#complete_common_string() 

" SuperTab like snippets behavior. 
"imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "<C-n>" : "<TAB>" 

" Recommended key-mappings

" <CR>: close popup and save indent.
"inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
endfunction

" <TAB>: completion
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y> neocomplcache#close_popup()
inoremap <expr><C-e> neocomplcache#cancel_popup()

" AutoComplPop like behavior. 
"let g:neocomplcache_enable_auto_select = 1 

" Shell like behavior(not recommended). 
"set completeopt+=longest 
"let g:neocomplcache_enable_auto_select = 1 
"let g:neocomplcache_disable_auto_complete = 1 
"inoremap <expr><TAB>  pumvisible() ? "<Down>" : "<TAB>" 
"inoremap <expr><CR>  neocomplcache#smart_close_popup() . "<CR>" 

" Enable omni completion. 
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS 
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags 
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS 
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete 
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags 

" Enable heavy omni completion. 
if !exists('g:neocomplcache_omni_patterns') 
let g:neocomplcache_omni_patterns = {} 
endif

set guioptions-=L " 隐藏左侧滚动条 
set guioptions-=r " 隐藏右侧滚动条