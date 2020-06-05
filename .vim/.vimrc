"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer: 
" 	Louis Kuang - @xwkuang5
"
" Original author:
"       Amir Salihefendic — @amix3k
"
" Leader: <space>
" Mnemonic mappings
"   f -> file
"   b -> buffer
"   t -> tag
"   s -> search 
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let $VIM = $HOME.'/.vim'
let $MYVIMRC = $VIM.'/.vimrc'
let s:bundle_dir = $VIM.'/bundle'

" Vim-Plug {{{

" runtime path (rtp) is set via the installation script
call plug#begin(s:bundle_dir)
" filesystem explorer
Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
" syntax checker
Plug 'scrooloose/syntastic'
" automatically update tags
" Plug 'xolox/vim-easytags'
" Plug 'xolox/vim-misc'
" tag bar (in-memory tags of current file)
Plug 'majutsushi/tagbar'
" easy commenting
Plug 'preservim/nerdcommenter'
" fuzzy search
" TODO: switch to fzf
Plug 'ctrlpvim/ctrlp.vim'
" statusline
Plug 'bling/vim-airline'
" auto-complete
Plug 'valloric/youcompleteme'
" fly grep
Plug 'wsdjeg/FlyGrep.vim'
" Vim-surround
Plug 'tpope/vim-surround'
" Vim-unimpaired
Plug 'tpope/vim-unimpaired'

call plug#end()
" }}}

" General {{{

" Set line number
set number

" Sets how many lines of history VIM has to remember
set history=500

set cursorline

set listchars=tab:→\ ,eol:↲

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread
" Check if file was changed outside of vim upon gaining focus or
" entering a buffer
autocmd FocusGained,BufEnter * checktime

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = " "

" There are two more ways that I know of to define customed prefix
" 1. via variable and command execution
"       let g:my_custom_key = <prefix>
"       execute 'nnoremap' g:my_custom_key . <suffix> <action>
" 2. via <nop> and mapping
"       nnoremap [unite]    <nop>
"       nmap     <prefix>   [unite]
"       nnoremap <silent> [unite]<suffix> <action>

" Map <space> to no-op in normal mode
nnoremap <space> <Nop>

" Fast saving
nnoremap <leader>fs :w!<cr>

" Use <leader>ev to open vimrc for editing
nnoremap <leader>ev :vsplit $MYVIMRC<cr>

" Use <leader>sv to source vimrc after changes
nnoremap <leader>sv :source $MYVIMRC<cr>

" Save session (overwrite existing)
nnoremap <leader>mk :mksession!<cr>

" }}}

" Tab, buffer, window {{{
" <leader><number> for tab
nnoremap <leader>1 1gt
nnoremap <leader>2 2gt
nnoremap <leader>3 3gt
nnoremap <leader>4 4gt
nnoremap <leader>5 5gt
nnoremap <leader>6 6gt
nnoremap <leader>7 7gt
nnoremap <leader>8 8gt
nnoremap <leader>9 9gt
nnoremap <leader>0 :tablast<cr>

" Close the current buffer
nnoremap <leader>bd :Bclose<cr>:tabclose<cr>gT

" Close all the buffers
nnoremap <leader>ba :bufdo bd<cr>

" List buffers and jump
nnoremap <leader>bl :ls!<cr>:b<space>
" }}}

" VIM user interface {{{

" Set 7 lines to the cursor - when moving vertically using j/k
" so stands for scrolloff - essentially, this ensures that there
" are at least <so> lines above and below the cursor
set so=7

" Avoid garbled characters in Chinese language windows OS
let $LANG='en' 
set langmenu=en
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" Turn on the Wild menu
" Wild menu is the graphical menu that shows up during completion
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

"Always show current position (line and column number)
set ruler

" Height of the command bar
set cmdheight=1

" A buffer becomes hidden when it is abandoned
set hidden

" Configure backspace so it acts as it should act
" set backspace=eol,start,indent
" set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases 
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch 

" Don't redraw while executing macros (good performance config)
set lazyredraw 

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch 
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Properly disable sound on errors on MacVim
if has("gui_macvim")
    autocmd GUIEnter * set vb t_vb=
endif


" Add a bit extra margin to the left
set foldcolumn=1

" Enable folding
set foldenable

" Open most folds my default
set foldlevelstart=10

" Fold based on indentation level, other options are marker, syntax
set foldmethod=indent

" }}}

" Colors and Fonts {{{

" Enable syntax highlighting
syntax enable 

" Enable 256 colors palette in Gnome Terminal
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif

try
    colorscheme desert
catch
endtry

set background=dark

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" }}}

" Files, backups and undo {{{

" Change backup to /tmp to avoid polluting the current directory
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup

" }}}

" Text, tab and indent {{{
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4
set softtabstop=4

" Linebreak on 500 characters
set lbr
set textwidth=80

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

" }}}

" Visual mode related {{{

" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

" }}}

" Moving around {{{

" Smart way to move between windows
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l

" Move vertically by visual line (don't skip over fake (wrapped around) line)
nnoremap j gj
nnoremap k gk

nnoremap <leader>l :bnext<cr>
nnoremap <leader>h :bprevious<cr>

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nnoremap <Leader>tl :execute "tabnext ".g:lasttab<CR>
autocmd TabLeave * let g:lasttab = tabpagenr()


" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
nnoremap <leader>te :tabedit <C-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
nnoremap <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers 
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" }}}

" Status line {{{
" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c

" }}}

" Mappings {{{

" Move a line of text using ALT+[jk] or Command+[jk] on mac
" nmap <M-j> mz:m+<cr>`z
" nmap <M-k> mz:m-2<cr>`z
" vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
" vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

" if has("mac") || has("macunix")
  " nnoremap <D-j> <M-j>
  " nnoremap <D-k> <M-k>
  " vnoremap <D-j> <M-j>
  " vnoremap <D-k> <M-k>
" endif

" <c-d> to delete a line in insert mode
inoremap <c-d> <esc>ddi

" use jk in insert mode to exit to normal mode
inoremap jk <esc>

" use <c-u> to convert current word to uppercase in insert mode
inoremap <c-u> <esc>vbUea

" map p to motion "i(" (within parenthesis)
onoremap p i(

" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
endif

" Map <esc> in noremal mode to nop to force learning of jk
" nnoremap <esc> <nop>

" }}}

" Filetype specific {{{
augroup configgroup
    " Clear previous configurations
    autocmd!
    autocmd VimEnter * highlight clear SignColumn
    autocmd BufWritePre *.txt,*.js,*.py,*.md,*.sh,*.java :call CleanExtraSpaces()
    autocmd FileType java setlocal formatprg=par\ -w80\ -T4

    autocmd FileType python setlocal commentstring=#\ %s
    autocmd BufEnter *.cls setlocal filetype=java
    autocmd BufEnter Makefile setlocal noexpandtab
    autocmd BufEnter *.sh setlocal tabstop=2
    autocmd BufEnter *.sh setlocal shiftwidth=2
    autocmd BufEnter *.sh setlocal softtabstop=2

    " enable overview for vimrc
    autocmd FileType vim setlocal foldmethod=marker
    autocmd FileType vim setlocal foldlevel=0

    autocmd FileType markdown setlocal tabstop=2
    autocmd FileType markdown setlocal shiftwidth=2
    autocmd FileType markdown setlocal softtabstop=2
augroup END

" }}}

" NerdTree {{{

" map <leader>ft (file tree) for NERDTreeToggle
nnoremap <leader>ft :NERDTreeToggle<cr>

" map <leader>fc center cursor at current file
nnoremap <leader>fc :NERDTreeFind<cr>

" Open NERDTree automatically when vim starts up on opening a directory


augroup nerdtreeconfig
    autocmd!
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") && v:this_session == "" | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
augroup END

" close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" }}}

" Ctags {{{
" enable asyncrhonous tags update
" let g:easytags_async = 1
" let g:easytags_auto_highlight = 0

" ctags - jump to tag
nnoremap <leader>td <c-]>
" ctags - jump to next definition of last tag
nnoremap <leader>tn :tn<cr>
" ctags - jump to the previous definition of previous tag
nnoremap <leader>tp :tp<cr>
" ctags - jump back up in stack
nnoremap <leader>t` <c-t>
" tagbar toggle
nnoremap <leader>tb :TagbarToggle<cr>
" }}}

"  Nerdcommenter {{{
let g:NERDSpaceDelims = 2
"  }}}

" Syntastic {{{
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_enable_highlighting = 0
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_mode_map = { 'mode': 'passive' }

let g:syntastic_c_check_header = 1
let g:syntastic_c_checkers = ['gcc', 'make']
let g:syntastic_c_config_file = '.syntastic_c_config'
" }}}

" Search {{{

nnoremap <leader>sf :CtrlP<cr>

" note :ts search tags using ctags
nnoremap <leader>st :CtrlPTag<cr>

nnoremap <leader>sb :CtrlPBuffer<cr>

nnoremap <leader>sg :FlyGrep<cr>

" }}}

" Misc {{{
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Quickly open a buffer for scribble
nnoremap <leader>q :e ~/buffer<cr>

" Quickly open a markdown buffer for scribble
nnoremap <leader>x :e ~/buffer.md<cr>

" Allows cursor change in tmux mode
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" Rename tabs to show tab number.
" (Based on http://stackoverflow.com/questions/5927952/whats-implementation-of-vims-default-tabline-function)
if exists("+showtabline")
    function! MyTabLine()
        let s = ''
        let wn = ''
        let t = tabpagenr()
        let i = 1
        while i <= tabpagenr('$')
            let buflist = tabpagebuflist(i)
            let winnr = tabpagewinnr(i)
            let s .= '%' . i . 'T'
            let s .= (i == t ? '%1*' : '%2*')
            let s .= ' '
            let wn = tabpagewinnr(i,'$')

            let s .= '%#TabNum#'
            let s .= i
            " let s .= '%*'
            let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
            let bufnr = buflist[winnr - 1]
            let file = bufname(bufnr)
            let buftype = getbufvar(bufnr, 'buftype')
            if buftype == 'nofile'
                if file =~ '\/.'
                    let file = substitute(file, '.*\/\ze.', '', '')
                endif
            else
                let file = fnamemodify(file, ':p:t')
            endif
            if file == ''
                let file = '[No Name]'
            endif
            let s .= ' ' . file . ' '
            let i = i + 1
        endwhile
        let s .= '%T%#TabLineFill#%='
        let s .= (tabpagenr('$') > 1 ? '%999XX' : 'X')
        return s
    endfunction
    set stal=2
    set tabline=%!MyTabLine()
    set showtabline=1
    highlight link TabNum Special
endif

" }}}

" Helper functions {{{

" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")

    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif

    if bufnr("%") == l:currentBufNum
        new
    endif

    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
    endif
endfunction

function! CmdLine(str)
    call feedkeys(":" . a:str)
endfunction 

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction
" }}}
