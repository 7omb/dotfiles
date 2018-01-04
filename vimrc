set nocompatible        " disable vi defaults
set encoding=utf-8      " use UTF-8

" --- Plugins -------------------------------------------------------
call plug#begin('~/.vim/plugged')

" General
Plug 'wincent/terminus'
Plug 'altercation/vim-colors-solarized'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'wesQ3/vim-windowswap'
Plug 'tpope/vim-unimpaired'
Plug 'qpkorr/vim-bufkill'
Plug 'breuckelen/vim-resize'

" Editing
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'Townk/vim-autoclose'
Plug 'godlygeek/tabular'
Plug 'sjl/gundo.vim'

" Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'rhysd/committia.vim'

" Motion
Plug 'easymotion/vim-easymotion'
Plug 'haya14busa/vim-asterisk'

" File handling
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } | Plug 'junegunn/fzf.vim' "fzf in vim
Plug 'mileszs/ack.vim'

" Completion
Plug 'szw/vim-tags'
Plug 'majutsushi/tagbar'
Plug 'ervandew/supertab'
Plug 'davidhalter/jedi-vim'
Plug 'sirver/ultisnips'
Plug 'honza/vim-snippets'
Plug 'w0rp/ale'

call plug#end()

" --- General Setup -------------------------------------------------
"  Colorscheme
set background=dark
colorscheme solarized

" General
set nobackup            " disable backups
set noswapfile          " disable swap files
set undofile            " use files for undo
set undodir=~/.vim/undo " undo directory
set backspace=indent,eol,start  " fix backspace not working problem
set complete-=i         " no completion based on includes (can be slow)
set nrformats-=octal    " don't use octal number formats

" File handling
set hidden              " hide buffers instead asking to save them
set autoread            " automatically reread a file if it has changed
set confirm             " instead of aborting because of unsaved changes, ask

" Line handling
set nomodeline          " dont parse modelines (modeline vulnerability)
set cursorline          " highlight cursor line
set number              " show line numbers
set relativenumber      " relative to current line
set display+=lastline   " show as much as possible of a line instad of '@'
set nowrap              " don't wrap lines
set laststatus=2        " always show a status line
set showcmd             " show last command in bottom bar
set colorcolumn=120     " visual hint for too long lines

" Indentation
set tabstop=4           " visual spaces per TAB
set softtabstop=4       " TAB equals 4 spaces
set shiftwidth=4        " indentation level 4 spaces
set expandtab           " convert TABs to spaces
set autoindent          " copy indent from previous line
" show tabs and trailing spaces
set list listchars=tab:→⋅,trail:⋅,nbsp:⋅

if has('autocmd')
    filetype plugin indent on
endif

if has('syntax')
    syntax enable
endif

" allow color schemes to do bright colors without forcing bold
if &t_Co == 8 && $TERM !~# '^linux\|^Eterm'
    set t_Co=16
endif

" load matchit.vim, if no newer version is installed
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
    runtime! macros/matchit.vim
endif

" view man pages in vim
runtime ftplugin/man.vim
let g:ft_man_open_mode = 'vert'
let g:ft_man_folding_enable = 1

if &history < 1000
    set history=1000
endif

if &tabpagemax < 50
    set tabpagemax=50
endif

" handling of variables
if empty(&viminfo)
    set viminfo^=!
endif
set sessionoptions-=options

" Scrolling
set scrolloff=1         " number of lines to show above or below the cursor
set sidescrolloff=5     " number of columns to show left and right of the cursor

" Searching
set incsearch           " search as chars are entered
set hlsearch            " highlight matches
" nicer highlighting
highlight Search cterm=bold ctermfg=LightBlue
highlight Search gui=bold guifg=LightBlue
set ignorecase          " case insensitive search
set smartcase           " except when explicitly using capital letters

" Pane splitting
set splitbelow          " new horizontal panes below current one
set splitright          " new vertical panes go right

" Wild menu
set wildmenu            " makes the command-line completion better
set wildmode=longest,list   " bash like wildmenu completion
set wildignore+=*.o,*.obj,.git,*.pyc,*.class,.svn
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz
set wildignore+=*.swp,*~,._*

" Folding
set foldenable          " enable folding
set foldmethod=indent   " fold based on indentation.
set foldlevelstart=9    " Shows most folds by default
set foldnestmax=5       " You're writing bad code if you need to up this one

" better line joins with comments using e.g. J
if v:version > 703 || v:version == 703 && has('patch541')
    set formatoptions+=j
endif

" --- Key Bindings ---------------------------------------------------
let mapleader=','
let maplocalleader=' '

" easy escape with fd
inoremap fd <esc>
inoremap <esc> <nop>

" behave nicely with wrapped lines
nnoremap j gj
nnoremap k gk

" save some keystrokes
nnoremap ; :
vnoremap ; :

" use tab to jump to matching (, [, {,...
nnoremap <tab> %
vnoremap <tab> %

" align blocks of text and keep them selected
vnoremap < <gv
vnoremap > >gv

" Make Q repeat the last recorded marcro
nnoremap Q @@

" easy vimrc editing
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" write to a file when sudo was forgotten with w!!
cmap w!! w !sudo tee % >/dev/null

" vim-asterisk
map * <Plug>(asterisk-z*)
map # <Plug>(asterisk-z#)

" clear highlights
nnoremap <leader>c :nohlsearch<cr>

" reformat text easily
nnoremap <leader>w gqip

" find any file in this git repo with ?
nnoremap ? :Files<cr>

" buffers/window handling
nnoremap <leader>b :Buffers<cr>
nnoremap <leader>l :Lines<cr>

" easily save files
nnoremap <leader>s :w<cr>

" Tagbar
nnoremap <leader>t :TagbarToggle<cr>

" Open NERDtree
nnoremap <silent> <leader><leader> :NERDTreeToggle<cr>
" Find current file in nerdtree
nnoremap <leader>f :NERDTreeFind<cr>
nnoremap <leader>e :edit <C-r>=expand('%:p:h') . '/'<cr>

" gundo tree
nnoremap <leader>u :GundoToggle<cr>

" Flip between files with <leader>.
noremap <leader>. :b#<cr>

" Navigation with C-h/j/k/l in tmux and vim
if exists('$TMUX')
    function! TmuxOrSplitSwitch(wincmd, tmuxdir)
        let previous_winnr = winnr()
        silent! execute "wincmd " . a:wincmd
        if previous_winnr == winnr()
            call system("tmux select-pane -" . a:tmuxdir)
            redraw!
        endif
    endfunction

    let previous_title = substitute(system("tmux display-message -p '#{pane_title}'"), '\n', '', '')
    let &t_ti = "\<Esc>]2;vim\<Esc>\\" . &t_ti
    let &t_te = "\<Esc>]2;". previous_title . "\<Esc>\\" . &t_te

    nnoremap <silent> <C-h> :call TmuxOrSplitSwitch('h', 'L')<cr>
    nnoremap <silent> <C-j> :call TmuxOrSplitSwitch('j', 'D')<cr>
    nnoremap <silent> <C-k> :call TmuxOrSplitSwitch('k', 'U')<cr>
    nnoremap <silent> <C-l> :call TmuxOrSplitSwitch('l', 'R')<cr>
else
    map <C-h> <C-w>h
    map <C-j> <C-w>j
    map <C-k> <C-w>k
    map <C-l> <C-w>l
endif

" resize windows easily
let g:vim_resize_disable_auto_mappings=1
nnoremap <silent> <left> :CmdResizeLeft<cr>
nnoremap <silent> <down> :CmdResizeDown<cr>
nnoremap <silent> <up> :CmdResizeUp<cr>
nnoremap <silent> <right> :CmdResizeRight<cr>

" use backspace and enter as paragraph commands
nnoremap <BS> {
onoremap <BS> {
vnoremap <BS> {
nnoremap <expr> <cr> empty(&buftype) ? '}' : '<cr>'
onoremap <expr> <cr> empty(&buftype) ? '}' : '<cr>'
vnoremap <cr> }

" F toggles easy-motion search
nmap F <Plug>(easymotion-prefix)s

" make a vertical split with vv
nnoremap <silent> vv :vsp<cr>
" make a horizontal split with VV
nnoremap <silent> VV :sp<cr>

" next/previous git hunks, undo hunk, undo hunk
nnoremap ]g :GitGutterNextHunk<cr>
nnoremap [g :GitGutterPrevHunk<cr>
nnoremap <C-u> :GitGutterUndoHunk<cr>

" jump to linting errors
nnoremap ]r :ALENextWrap<cr>
nnoremap [r :ALEPreviousWrap<cr>

" use ag instead of ack for ack.vim
if executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif
nnoremap <leader>a :Ack<space>

" --- Plugin Settings --------------------------------------------------
" NERDTree
let NERDTreeChDirMode=2
let NERDTreeIgnore=['\.vim$', '\~$', '\.pyc$', '\.swp$']
let NERDTreeSortOrder=['\/$', '\.py$', '*', '\.swp$',  '\~$']
let NERDTreeShowBookmarks=1
" make quitting when only NERDtree is open actually quit
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" supertab
let g:SuperTabDefaultCompletionType="context"

" jedi-vim
let g:jedi#popup_select_first=0
autocmd FileType python setlocal completeopt-=preview   " don't show docstring on completion

" ultisnippets
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<C-b>"
let g:UltiSnipsJumpBackwardTrigger="<C-z>"

" ALE
let g:airline#extensions#ale#enabled = 1    " show errors in airline

" airline
let g:airline_theme='badwolf'
let g:airline#extensions#tabline#enabled=1  " use bufferline
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.maxlinenr = '☰'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = '∄'
let g:airline_symbols.whitespace = 'Ξ'

" --- Language Settings ----------------------------------------------
augroup configgroup
    autocmd!
    autocmd VimEnter * highlight clear SignColumn
    autocmd BufWritePre * call StripTrailingWhite()
    autocmd BufEnter Makefile setlocal noexpandtab
augroup END

" --- Functions ------------------------------------------------------
function! StripTrailingWhite()
    let l:winview = winsaveview()
    silent! %s/\s\+$//
    call winrestview(l:winview)
endfunction

