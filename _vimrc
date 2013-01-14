set nocompatible    "非兼容模式
syntax on           "开启语法高亮
set mouse=a         "控制台启用鼠标
set cursorline      "高亮当前行背景
set backspace=2     "退格键可以删除任何东西
set incsearch       "增量搜索
set magic           "使用正则时，除了$ . * ^以外的元字符都要加反斜线
set hlsearch        "搜索时高亮显示
set nobackup        "无备份
set history=400

" 自动重新加载vimrc文件
autocmd! bufwritepost _vimrc source %

filetype on
filetype plugin on
filetype indent on

"Set mapleader
let mapleader = ";"
let g:mapleader = ";"

" 快速保存
nmap <leader>w :w!<cr>

if exists("&ambiwidth")
    set ambiwidth=double
endif

"使gvim启动时最大化
"au GUIEnter * simalt ~x

"Favorite filetype
set ffs=unix,dos,mac

nmap <leader>fd :se ff=dos<cr>
nmap <leader>fu :se ff=unix<cr>

set so=7

"Turn on WiLd menu
set wildmenu

"The commandbar is 2 high
set cmdheight=2

"Do not redraw, when running macros.. lazyredraw
set lz

"Change buffer - without saving
set hid

"Bbackspace and cursor keys wrap to
set whichwrap+=<,>,h,l

"No sound on errors.
set noerrorbells
set novisualbell
set t_vb=

"show matching bracet
set showmatch

"How many tenths of a second to blink
set mat=4

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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Command-line config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files and backup
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Turn backup off
set nowb

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Folding
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Enable folding, I find it very useful
set foldenable
"set foldlevel=0
set foldmarker={,}  "缩进符号
set foldmethod=indent   "缩进作为折叠标识
set foldlevel=100   "不自动折叠
set foldopen-=search    "搜索时不打开折叠
set foldopen-=undo  "撤销时不打开折叠
" 空格键进行折叠
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>


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
"noremap <Leader>m :%s/r//g<CR>

"Paste toggle - when pasting something in, don't indent.
"set pastetoggle=<F3>

"Remove indenting on empty line
map <F2> :%s/\s*$//g<cr>:noh<cr>''

"Super paste
ino <C-v> <esc>:set paste<cr>mui<C-R>+<esc>mv'uV'v=:set nopaste<cr>

set background=dark "背景色
color desert
set ruler           "在左下角显示当前文件所在行
set showcmd         "在状态栏显示命令
set showmatch       "显示匹配的括号
set ignorecase      "大小写无关匹配
set smartcase       "只能匹配，即小写全匹配，大小写混合则严格匹配
set report=0        "显示修改次数
set number          "行号
set fileencodings=ucs-bom,UTF-8,GBK,BIG5,latin1
set fileencoding=UTF-8
set fileformat=unix "换行使用unix方式
set noerrorbells    "不显示响铃
set visualbell      "可视化铃声
set updatecount=0   "不使用交换文件

" ;hc highlight column高亮当前列
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
set lbr
"显示TAB字符为<+++
set list
set list listchars=tab:<+

set lazyredraw  "延迟重绘
set guioptions-=m   "不显示菜单
set guioptions-=T   "不显示工具栏

"回到上次文件打开所在行
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
            \| exe "normal g'\"" | endif

set filetype=python
au BufNewFile,BufRead *.py,*.pyw setf python
au BufNewFile,BufRead *vimrc setf vim

set helplang=cn

set novisualbell
set lines=40
set columns=140


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


" Tag list (ctags)
let Tlist_Ctags_Cmd='ctags.exe'
set tags=tags;
set autochdir
let Tlist_Ctags_Cmd = 'ctags.exe'
let Tlist_Show_One_File = 1            "不同时显示多个文件的tag，只显示当前文件的
let Tlist_Exit_OnlyWindow = 1          "如果taglist窗口是最后一个窗口，则退出vim
"let Tlist_Use_Right_Window = 1         "在右侧窗口中显示taglist窗口
map <F3> :Tlist<cr>

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
let g:pymode_rope_autoimport_underlineds = 1
let g:pymode_rope_codeassist_maxfixes = 10
let g:pymode_rope_sorted_completions = 1
let g:pymode_rope_extended_complete = 1
let g:pymode_rope_autoimport_modules = ["os","shutil","datetime","re","urllib","urllib2"]
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

" pymode的跳转到函数定义处Ctrl c放开后按g，重新定义为Ctrl g了
map <C-g> <C-c>g

" 自动import g:pymode_rope_autoimport_modules中定义的但是当前py文件还没有import的
map <leader>im :RopeAutoImport<cr>

" django
"au FileType python set ft=python.django
"au FileType html set ft=htmldjango.html

"显示了python文档并完成选择后，窗口关闭
autocmd CursorMovedI *  if pumvisible() == 0|silent! pclose|endif
autocmd InsertLeave * if pumvisible() == 0|silent! pclose|endif

" 缩进线
let g:indent_guides_guide_size=1 "宽度为1

" 格式化js代码
nnoremap <silent> <leader>js :call g:Jsbeautify()<cr>

" tab转换为4个空格tab to space
map <leader>t2s :%s/<tab>/    /g<cr>

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

" 打开寄存器:reg<cr>

" pymode默认的<leader>r为运行当前py文件，所以修改一下
let g:pymode_run_key = '<leader>py'

" zencoding
map <leader>z <c-y>,
" powerline 显示绝对全路径
let g:Powerline_stl_path_style = 'full'

" 自动完成[tab]键
" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

set guioptions-=L " 隐藏左侧滚动条
set guioptions-=r " 隐藏右侧滚动条

" 以不同的彩色mark高亮单词
"http://www.vim.org/scripts/script.php?script_id=2666
" ;m高亮当前单词
" ;n如果光标处有高亮那么取消此单词的高亮，如果没有那么将会取消所有单词的高亮
" 标记颜色之后会默认为搜索此单词，所以#和*的时候会针对此单词
" 使用18种颜色
let g:mwDefaultHighlightingPalette = 'extended'
" 使用更多的颜色(一般没有这个必要了...)
"let g:mwDefaultHighlightingPalette = 'maximum'
" 只高亮9个单词
"let g:mwDefaultHighlightingNum = 9
