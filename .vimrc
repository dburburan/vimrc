set nocompatible

"-----------------------------------------------------------------------------
" GUI Options
"-----------------------------------------------------------------------------
set guioptions-=T "No toolbar
set guioptions-=m "No menu
set guifont=Courier_New:h10:cANSI

"-----------------------------------------------------------------------------
" Plugins
"-----------------------------------------------------------------------------

" Pathogen to auto handle plugin directories
execute pathogen#infect()

" Custom solarized colors

" CtrlP for fast fuzzy file open
" BBye for buffer deletion without wrecking splits
" Indent object, for commands like vii, etc
" PseudoCL + Oblique for improved in-buffer regex

" Mm optional~
" YouCompleteMe for completion

" Language Specific
" -----------------
" Coffeescript syntax highlighting
" Vaxe for haxe highlighting

" CtrlP
let g:ctrlp_extensions = ['line']

" Oblique
let g:oblique#clear_highlight=0
let g:oblique#incsearch_highlight_all=1
hi clear ObliqueCurrentMatch

"-----------------------------------------------------------------------------

" Options we always want
set shortmess+=I
set hidden "hidden buffers
set virtualedit=onemore,block
set noswapfile
set number
set wildmode=longest,list,full
set wildmenu
set ruler

"-----------------------------------------------------------------------------
" Syntax Highlighting
"-----------------------------------------------------------------------------

syntax on
set background=dark
colorscheme solarized
cnoreabbrev normalc let g:solarized_contrast="normal" \| colorscheme solarized
cnoreabbrev highc let g:solarized_contrast="high" \| colorscheme solarized

" TODO: Really high contrast mode
"1.5X Contrast
"  let s:base02      = "#0A5063"
"  let s:base01      = "#83A5AF"
"  let s:base00      = "#97B8C4"
"  let s:base0       = "#C4DEE1"
"  let s:base1       = "#DCF1F1"
"  let s:base2       = "#FFF8E4"
"  let s:base3       = "#FFFFFF"
"  let s:yellow      = "#FFC100"
"  let s:orange      = "#FF5E1B"
"  let s:red         = "#FF3936"
"  let s:magenta     = "#FF419D"
"  let s:violet      = "#8C93FF"
"  let s:blue        = "#2EA8FF"
"  let s:cyan        = "#3EF1E4"
"  let s:green       = "#A9ED0A"

"1.1X Contrast
"  let s:base02      = "#073B48"
"  let s:base01      = "#607980"
"  let s:base00      = "#6F8790"
"  let s:base0       = "#90A2A5"
"  let s:base1       = "#A1B1B1"
"  let s:base2       = "#FFF8E4"
"  let s:base3       = "#FFFFFF"
"  let s:yellow      = "#C79600"
"  let s:orange      = "#DF5218"
"  let s:red         = "#F23633"
"  let s:magenta     = "#E83B8E"
"  let s:violet      = "#767CD7"
"  let s:blue        = "#2998E7"
"  let s:cyan        = "#2EB1A7"
"  let s:green       = "#7CAD07"

" Less in-your-face invisible characters
" TODO: Deal with high contrast mode
let s:gui_base02 = "#073642"
let s:cterm_base02 = "0"
exe "hi! SpecialKey gui=none guibg=bg guifg=" .s:gui_base02 ." ctermfg=" .s:cterm_base02
exe "hi! NonText    gui=none guibg=bg guifg=" .s:gui_base02 ." ctermfg=" .s:cterm_base02

hi! search gui=none guibg=#102430

"-----------------------------------------------------------------------------
" Custom key mappings
"-----------------------------------------------------------------------------

" Faster Ex mode access
noremap ; :
" As a result, provide new mappings for search by character
noremap : ,
noremap " ;
" And as a result of that, provide mappings for using registers, which is also more convenient
noremap ' "
" We lost the ability to jump to mark line (') but we can use jump to mark exactly (`) instead

" Come out of insert mode assuming it was insert mode not add mode
" Also map enter to esc, and add an undo point there
inoremap <silent> <esc> <esc>`^
inoremap <silent> <cr> <esc>`^
inoremap <s-cr> <c-g>u<cr>
inoremap <c-cr> <c-g>u<cr>

vnoremap <cr> <esc>

" Enter works to put a newline in normal mode
nnoremap <cr> i<cr>

" Swap b and q keys
" Makes w/q move forward/back a word positionally related
" Record macro / enter Ex mode ends up on b / B which is fine
noremap b q
noremap q b
noremap Q B
noremap B Q

" Swap ctrl-e and ctrl-u
" Makes ctrl+e/d up/down a page keys positionally related
" Makes ctrl+y/u up/down a line keys positionally related
noremap <c-e> <c-u>
noremap <c-u> <c-e>

" Make arrow keys useful for browsing
noremap <up> <c-y>k
noremap <down> <c-e>j

" Map H and L to Home and End, lose top of screen / bottom of screen movements which we never use anyway
" Also for end of line more one more to the right for virtualedit=onemore
noremap H ^
noremap L $l

"-----------------------------------------------------------------------------

" Indentation
filetype indent on
set autoindent

let mapleader = "\\"
set timeoutlen=300

" Saving
cnoreabbrev w up
noremap <silent> <c-s> :up<cr>

" Performance thingies
set lazyredraw
set ttyfast

" Allow undoing mistakes deleting words and lines in undo mode
inoremap <c-u> <c-g>u<c-u>
inoremap <c-w> <c-g>u<c-w>

" Make yank to end of line consistent
map Y y$

" More flexible insert mode
set backspace=indent,eol,start

" Auto reload files that have changed
set autoread

" Text wrap
" set nowrap
set wrap
set breakindent
set breakindentopt=shift:-1
set showbreak=~
set linebreak
set breakat=\ \	;:,/?\\([{
set cpoptions+=n
noremap j gj
noremap k gk
inoremap <down> <c-o>gj
inoremap <up> <c-o>gk

" Tab setup
set tabstop=4
set shiftwidth=2
set smarttab
set expandtab

" Visualise whitespace
set list
set listchars=tab:>.,extends:>,nbsp:-,trail:.

" Delete buffers without closing window
nnoremap <leader>q :Bdelete<cr>
nnoremap <leader>q! :Bdelete!<cr>

" Disable visual mode on mouse drag
noremap <leftdrag> <leftmouse>
noremap! <leftdrag> <leftmouse>

" Window tab setup
map <c-tab> gt
map <c-s-tab> gT
map <silent> <c-t> :tabedit<cr>

" Change splits by pressing ctrl+hjkl
noremap <silent> <c-h> :wincmd h<cr>
noremap <silent> <c-j> :wincmd j<cr>
noremap <silent> <c-k> :wincmd k<cr>
noremap <silent> <c-l> :wincmd l<cr>

" Make space center screen on cursor
noremap <space> zz

" Don't deselect visual block on changing indent
vnoremap < <gv
vnoremap > >gv

" Search options
set ignorecase
set smartcase
set incsearch
set hlsearch

" Substitute all matches on a line by default
set gdefault

" Encodings
set fileformats=unix,dos
setglobal nobomb
set encoding=utf-8
set fileencoding=utf-8

cnoreabbrev ffdos silent %s/\v^\n// | %s/\v([^\r])\n/\1/ | %s/\r//

" Change current dir to current file
cnoreabbrev cdc cd %:p:h

" Buffer copy and paste
nnoremap <silent> <leader>bc :let bufferclip=bufnr('%')<cr>
nnoremap <silent> <leader>bv :execute "b ".bufferclip<cr>

" Session shortcuts
set ssop-=options
cnoreabbrev ss mks! session.vim
cnoreabbrev sload so session.vim
