set nocompatible    "�Ǽ���ģʽ
syntax on           "�����﷨����
set mouse=a         "����̨�������
set cursorline      "������ǰ�б���
set backspace=2     "�˸������ɾ���κζ���
set incsearch       "��������
set magic           "ʹ������ʱ������$ . * ^�����Ԫ�ַ���Ҫ�ӷ�б��
set hlsearch        "����ʱ������ʾ
set nobackup        "�ޱ���
set history=400

filetype on
filetype plugin on
filetype indent on

"Set mapleader
let mapleader = ";"
let g:mapleader = ";"

" ���ٱ���
nmap <leader>w :w!<cr>

if exists("&ambiwidth")
    set ambiwidth=double
endif

"ʹgvim����ʱ���
au GUIEnter * simalt ~x

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
if exists("&foldenable")
    set fen
endif

if exists("&foldlevel")
    set fdl=0
endif


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
" => Tag list (ctags) - not used
""""""""""""""""""""""""""""""
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

set background=dark "����ɫ
color desert
set ruler           "�����½���ʾ��ǰ�ļ�������
set showcmd         "��״̬����ʾ����
set showmatch       "��ʾƥ�������
set ignorecase      "��Сд�޹�ƥ��
set smartcase       "ֻ��ƥ�䣬��Сдȫƥ�䣬��Сд������ϸ�ƥ��
set report=0        "��ʾ�޸Ĵ���
set number          "�к�
set fileencodings=ucs-bom,UTF-8,GBK,BIG5,latin1
set fileencoding=UTF-8
set fileformat=unix "����ʹ��unix��ʽ
set noerrorbells    "����ʾ����
set visualbell      "���ӻ�����
set foldmarker={,}  "��������
set foldmethod=indent   "������Ϊ�۵���ʶ
set foldlevel=100   "���Զ��۵�
set foldopen-=search    "����ʱ�����۵�
set foldopen-=undo  "����ʱ�����۵�
set updatecount=0   "��ʹ�ý����ļ�

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

"��������
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab
set smarttab
set lbr
"��ʾTAB�ַ�Ϊ<+++
set list
set list listchars=tab:<+

if has("gui_running")
    set lines=25
    set columns=80
    set lazyredraw  "�ӳ��ػ�
    set guioptions-=m   "����ʾ�˵�
    set guioptions-=T   "����ʾ������
    set guifont=consolas\ 10
endif

"�ص��ϴ��ļ���������
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
            \| exe "normal g'\"" | endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => python
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set filetype=python
au BufNewFile,BufRead *.py,*.pyw setf python

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => ctags
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let Tlist_Ctags_Cmd='$Vim/vim73/ctags.exe'
set tags=tags; 
set autochdir 

set helplang=cn

set novisualbell
set lines=30 
set columns=118

set guifont=Bitstream_Vera_Sans_Mono:h10:cANSI

" [����|��ʾ]�˵��� ==> F5
set guioptions-=m " Ĭ������
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

"When .vimrc is edited, reload it

""""""""""""""""""""""""""""""
" Tag list (ctags)
""""""""""""""""""""""""""""""
let Tlist_Ctags_Cmd = 'F:/dev/Vim/vim73/ctags.exe'
let Tlist_Show_One_File = 1            "��ͬʱ��ʾ����ļ���tag��ֻ��ʾ��ǰ�ļ���
let Tlist_Exit_OnlyWindow = 1          "���taglist���������һ�����ڣ����˳�vim
"let Tlist_Use_Right_Window = 1         "���Ҳര������ʾtaglist����

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

"zc���۵���������zo��չ������,shift+k���鿴��괦�ĺ������ĵ�
" ����pymode�ṩ���۵����������⣬������ã���python_edit.vim����
let pymode_folding = 0

" pymode����ת���������崦Ctrl c�ſ���g�����¶���ΪCtrl g��
map <C-g> <C-c>g

" �Զ�import g:pymode_rope_autoimport_modules�ж���ĵ��ǵ�ǰpy�ļ���û��import��
map <leader>im :RopeAutoImport<cr>

" django
"au FileType python set ft=python.django
"au FileType html set ft=htmldjango.html

"��ʾ��python�ĵ������ѡ��󣬴��ڹر�
autocmd CursorMovedI *  if pumvisible() == 0|silent! pclose|endif
autocmd InsertLeave * if pumvisible() == 0|silent! pclose|endif

" ������
let g:indent_guides_guide_size=1 "���Ϊ1

" ��ʽ��js����
nnoremap <silent> <leader>js :call g:Jsbeautify()<cr>

" tabת��Ϊ4���ո�tab to space
map <leader>t2s :%s/<tab>/    /g<cr>

" > <��������
vnoremap < <gv
vnoremap > >gv

set cc=79 " ����� set colorcolumn=79
set fo+=m " ����40������
set tw=79

" ;ig������ǰ��

" ��79�и�����ɫ
highlight ColorColumn guibg=DarkGray
highlight ColorColumn ctermbg=DarkGray


" python_editing.vim 
" F�۵���ǰ�ļ���Python���룬f�۵�������ں������ࣩ�Ĵ���
" ��ʼ���۵����д���
call ToggleFold()


" ctrlp.vim
" https://github.com/kien/ctrlp.vim.git
" ctrl+p���ļ���������
" �ڵ���������Ctrl v�����зִ򿪣�<C-t>�±�ǩ��
" ����ı�������Ĺ����ļ���Ҫִ��һ��:ClearAllCtrlPCaches
noremap <C-W><C-U> :CtrlPMRU<CR>
nnoremap <C-W>u :CtrlPMRU<CR>
let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$\|.rvm$\|\.wsgic$\|\.gif$\|\.png$\|\.jpg$\|\.bmp$\|\.pyc$\|\.pyo$'
"let g:ctrlp_working_path_mode=0
let g:ctrlp_match_window_bottom=1
let g:ctrlp_max_height=15
let g:ctrlp_match_window_reversed=0
let g:ctrlp_mruf_max=500
let g:ctrlp_follow_symlinks=1


" ctags��ת
" <C-]>�������崦 <C-t>���� <C-o>

" latex
set shellslash
set grepprg=grep\ -nH\ $*
let g:tex_flavor='latex'

" python
map [r :w <CR>:! python % <CR>
map [o :! python -i % <CR>
map [t :! rst2html.py % %<.html <CR>

" �򿪼Ĵ���
map <leader>r :reg<cr>
" pymodeĬ�ϵ�<leader>rΪ���е�ǰpy�ļ��������޸�һ��
let g:pymode_run_key = '<leader>py'

" zencoding
map <leader>z <c-y>,
" powerline ��ʾ����ȫ·��
let g:Powerline_stl_path_style = 'full'

" �Զ����[tab]��
" Enable omni completion. 
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS 
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags 
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS 
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete 
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags 

set guioptions-=L " ������������ 
set guioptions-=r " �����Ҳ������
