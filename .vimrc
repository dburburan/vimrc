set nocompatible

" Useful map mode (normal, visual, operator-pending) same as noremap but without select mode
" Makes overwriting by typing work when selecting (shift+move in insert mode)
command! -nargs=* -complete=mapping NXOnoremap nnoremap <args>|xnoremap <args>|onoremap <args>

"-----------------------------------------------------------------------------
" Plugins Used
"-----------------------------------------------------------------------------

" Pathogen to auto handle plugin directories
execute pathogen#infect()

" Custom solarized colors

" CtrlP for fast fuzzy file open
" let g:ctrlp_extensions = ['line']
" No longer used - see Unite instead

" BBye for buffer deletion without wrecking splits

" Indent object, for commands like vii, etc

" vim-repeat: Repeat plugin commands with '.'

" vim-surround: add parentheses, quotes, etc, around selections

" vim-fugitive: git wrapper

" Optionally- YouCompleteMe for completion

" vim-easy-align:
xmap <Enter> <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" Oblique + PseudoCL for improved in-buffer regex
let g:oblique#clear_highlight=0
let g:oblique#incsearch_highlight_all=1
let g:oblique#very_magic=1
hi clear ObliqueCurrentMatch

" vim-multiple-cursors
" It doesn't work with exclusive selection so temporarily set inclusive selection
" Also interferes with our trick to move cursor coming out of insert mode so turn that off too
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<C-c>'
function! Multiple_cursors_before()
  set selection=inclusive
  inoremap <esc> <esc>
  inoremap <c-cr> <esc>
  noremap u <nop>
  noremap <c-r> <nop>
endfunction
function! Multiple_cursors_after()
  set selection=exclusive
  inoremap <esc> <esc>`^
  inoremap <c-cr> <esc>`^
  unmap u
  unmap <c-r>
endfunction

" Unite
"call unite#filters#matcher_default#use(['matcher_fuzzy'])
"call unite#filters#sorter_default#use(['sorter_rank'])
call unite#custom#source('buffer,file,file/new,file_rec,file_rec/async', 'matchers', 'matcher_fuzzy')
"call unite#custom#source('buffer,file,file_rec,file_rec/async,line', 'sorters', 'sorter_selecta')
call unite#custom#source('buffer,file,file_rec,file_rec/async', 'sorters', 'sorter_rank')
" call unite#custom#source('file_rec/async','sorters','sorter_rank', )
" replacing unite with ctrl-p
" let g:unite_enable_start_insert=1
let g:unite_source_history_yank_enable=1
let g:unite_prompt='» '
let g:unite_split_rule = 'botright'
let g:unite_source_rec_async_command = ['gfind']
"if executable('ag')
"  let g:unite_source_grep_command='ag'
"  let g:unite_source_grep_default_opts='--nocolor --nogroup -S -C4'
"  let g:unite_source_grep_recursive_opt=''
"endif
function! s:unite_keybindings()
  inoremap <buffer> <silent> <esc> <esc>`^
  inoremap <buffer> <silent> <s-cr> <esc>`^
  noremap <buffer> <silent> <c-k> :wincmd k<cr>
  " map <buffer> <s-cr> <Plug>(unite_do_default_action)
  " imap <buffer> <s-cr> <Plug>(unite_do_default_action)
endfunction
autocmd FileType unite call s:unite_keybindings()
nnoremap <silent> <c-p> :Unite -auto-resize file file_rec/async -buffer-name=unitefiles -resume<cr>
nnoremap <silent> <c-f> :Unite -auto-resize line<cr>

" Language Specific
" -----------------
" Coffeescript syntax highlighting
" Vaxe for haxe highlighting

" Racket
let g:paredit_mode=0

"-----------------------------------------------------------------------------
" GUI Options
"-----------------------------------------------------------------------------
set guioptions-=T "No toolbar
set guioptions-=m "No menu
set guifont=Courier_New:h10:cANSI

" Allow quickly setting font size with command
command! -nargs=1 Fontsize set guifont=Courier_New:h<args>:cANSI
cnoreabbrev fs Fontsize

"-----------------------------------------------------------------------------
" Options we always want
"-----------------------------------------------------------------------------

set shortmess+=I
set hidden "hidden buffers
set virtualedit=onemore,block
behave mswin
set selection=exclusive
set whichwrap+=h,l,<,>,[,]
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
cnoreabbrev nc let g:solarized_contrast="normal" \| colorscheme solarized
cnoreabbrev hc let g:solarized_contrast="high" \| colorscheme solarized

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
" TODO: Deal with high contrast mode and inverted mode
let s:base03       = "#0f0f0f"
let s:gui_base02   = "#073642"
let s:cterm_base02 = "0"

exe "hi! SpecialKey gui=none guibg=bg guifg=" .s:gui_base02 ." ctermfg=" .s:cterm_base02
exe "hi! NonText    gui=none guibg=bg guifg=" .s:gui_base02 ." ctermfg=" .s:cterm_base02

exe "hi! folded guibg=" .s:base03
hi! search gui=none guibg=#102430

"-----------------------------------------------------------------------------
" Modifying Default Vim Keys
"-----------------------------------------------------------------------------

let mapleader = "\\"
set timeoutlen=300

" Faster Ex mode access
NXOnoremap ; :
" As a result, provide new mappings for search by character
NXOnoremap : ,
NXOnoremap " ;
" And as a result of that, provide mappings for using registers, which is also more convenient
NXOnoremap ' "
" We changed the ability to jump to mark line (') but we can use jump to mark exactly (`) instead or the following: (,)
NXOnoremap , '

" Come out of insert mode assuming it was insert mode not add mode
" Also map shift/ctrl+enter to esc
inoremap <silent> <esc> <esc>`^
inoremap <silent> <s-cr> <esc>`^

" Shift+enter easier to press than escape
noremap <s-cr> <esc>

" Add an undo point for inserting newlines
inoremap <cr> <c-g>u<cr>

" Swap b and q keys
" Makes w/q move forward/back a word positionally related
" Record macro / enter Ex mode ends up on b / B which is fine
NXOnoremap b q
NXOnoremap q b
NXOnoremap Q B

" Rather than go to Ex mode, make B play the macro in register b
NXOnoremap B @b

" Swap ctrl-e and ctrl-u, and swap the resultant ctrl-y and ctrl-u
" Makes ctrl+e/d up/down a page keys positionally related
" Makes ctrl+u/y up/down a line keys positionally related
noremap <c-e> <c-u>
noremap <c-y> <c-e>
noremap <c-u> <c-y>

" Make arrow keys useful for scrolling document when you're not really editing
NXOnoremap <up> <c-y>k
NXOnoremap <down> <c-e>j

" Map H and L to Home and End, lose top of screen / bottom of screen movements which we never use anyway
NXOnoremap H g^
NXOnoremap L g$

"-----------------------------------------------------------------------------
" Windows keys
"-----------------------------------------------------------------------------

" Copy, cut, paste
noremap <c-x> "+d
noremap <c-c> "+y
noremap <c-v> "+gP
cnoremap <c-v> <c-r>+
inoremap <c-v> <c-g>u<c-o>"+gP

" Undo and redo. We lose c-y for scrolling, but I never really used it
noremap <c-z> u
inoremap <c-z> <c-o>u
noremap <c-y> <c-r>
inoremap <c-y> <c-o><c-r>

" Provide an alternative to visual block mode
xnoremap v <c-v>
NXOnoremap <leader>v <c-v>

" Tabs
noremap <c-tab> gt
noremap <c-s-tab> gT
inoremap <c-tab> <c-o>gt
inoremap <c-s-tab> <c-o>gT
noremap <silent> <c-t> :tabedit<cr>

"-----------------------------------------------------------------------------
" Folding
"-----------------------------------------------------------------------------



"-----------------------------------------------------------------------------
" Convenience Shortcuts
"-----------------------------------------------------------------------------

" Saving
cnoreabbrev w up
noremap <silent> <c-s> :up<cr>
inoremap <silent> <c-s> <c-o>:up<cr>

" Delete buffers without closing window
nnoremap <leader>q :Bdelete<cr>
nnoremap <leader>q! :Bdelete!<cr>

" Make space center screen on cursor
NXOnoremap <space> zz
inoremap <c-space> <c-o>zz

" Repair file with mixed up newline encodings
function RepairFileNewlines()
  %s/\v^\n//
  %s/\v([^\r])\n/\1/
  %s/\v\r//
endfunction
cnoreabbrev fffix call RepairFileNewlines()<cr>

" Change current dir to current file
cnoreabbrev cdc cd %:p:h

" Buffer copy and paste
nnoremap <silent> <leader>bc :let bufferclip=bufnr('%')<cr>
nnoremap <silent> <leader>bv :execute "b ".bufferclip<cr>

" Execute line under cursor as Ex command
nnoremap <leader>e :execute getline(".")<cr>

" Session shortcuts
set ssop-=options
function! SaveSession()
  mksession! session.vim
  call writefile([getcwd()], $HOME."/.vimsession")
  echo "Session saved."
endfunction
function! LoadSessionRecent()
  for path in readfile($HOME."/.vimsession", '', 1)
    execute 'cd' fnameescape(path)
  endfor
  source session.vim
endfunction
cnoreabbrev ss call SaveSession()<cr>
cnoreabbrev sl source session.vim<cr>
cnoreabbrev slr call LoadSessionRecent()<cr>

" Diff
NXOnoremap <leader>d :call ToggleDiff()<cr>
function! ToggleDiff()
  if &diff
    diffoff
  else
    diffthis
  endif
endfunction
nnoremap <leader>g :diffget<cr>
nnoremap <leader>p :diffput<cr>
xnoremap <leader>g :'<,'>diffget<cr>
xnoremap <leader>p :'<,'>diffput<cr>
NXOnoremap <leader>u :diffupdate<cr>

"-----------------------------------------------------------------------------
" Misc Config
"-----------------------------------------------------------------------------

" Status Line
set noruler
set laststatus=2
let s:red = "#dc322f"
exe "hi User1 ctermfg=red gui=reverse guifg=" .s:red ." guibg=" .s:gui_base02
set statusline=%1(%1*%M%*%)%<%f\ %h%r%=%-14.(%l,%c%V%)\ %P

" Title Bar
set title
" Show pwd and filename in title bar, but show the end of the path first, and don't bother showing $HOME
function! TitleString()
  if getcwd() ==# $HOME
    return expand('%:t')
  else
    return split(getcwd(),'\\\|\/')[-1]." - ".expand('%:t')." - ".getcwd()
endfunction
set titlestring=%{TitleString()}%<

" Indentation
filetype on
filetype indent on
filetype plugin on
set autoindent

" Performance thingies
set lazyredraw
set ttyfast

" Allow undoing mistakes after deleting words and lines in insert mode
inoremap <c-u> <c-g>u<c-u>
inoremap <c-w> <c-g>u<c-w>

" Make yank to end of line consistent with shift-C or shift-D
NXOnoremap Y y$

" When starting linewise visual block mode, move cursor to start of line
nnoremap V g^V

" More flexible insert mode
set backspace=indent,eol,start

" Auto reload files that have changed
set autoread

" Diff options
set diffopt=filler,vertical

" Text wrap
set wrap
set breakindent
set breakindentopt=min:5,shift:-1
set showbreak=~
set linebreak
set breakat=\ \	;:,/?\\([{
set cpoptions+=n
set textwidth=0
" Turn explicit wrap off on file open just in case some filetype plugin has other ideas
autocmd BufRead * setlocal textwidth=0
NXOnoremap j gj
NXOnoremap k gk
inoremap <down> <c-o>gj
inoremap <up> <c-o>gk

" Dealing with super long lines in word wrap
set display+=lastline

" Visualise whitespace
set list
set listchars=tab:>.,extends:>,nbsp:-,trail:. "This is also set in tab setup below

" Tab setup
set smarttab
function! UseTabs()
  bufdo set tabstop=2
  bufdo set shiftwidth=2
  bufdo set noexpandtab
  set listchars=tab:\ \ ,extends:>,nbsp:-,trail:.
endfunction
function! UseSpaces()
  bufdo set tabstop=2
  bufdo set shiftwidth=2
  bufdo set expandtab
  set listchars=tab:>.,extends:>,nbsp:-,trail:.
endfunction
execute UseSpaces()
nnoremap <silent> <leader><tab> mM:execute UseTabs()<cr>`M
nnoremap <silent> <leader><space> mM:execute UseSpaces()<cr>`M

" Disable visual mode on mouse drag
noremap <leftdrag> <leftmouse>
noremap! <leftdrag> <leftmouse>

" Change splits by pressing ctrl+hjkl
noremap <silent> <c-h> :wincmd h<cr>
noremap <silent> <c-j> :wincmd j<cr>
noremap <silent> <c-k> :wincmd k<cr>
noremap <silent> <c-l> :wincmd l<cr>
inoremap <silent> <c-h> <c-o>:wincmd h<cr>
inoremap <silent> <c-j> <c-o>:wincmd j<cr>
inoremap <silent> <c-k> <c-o>:wincmd k<cr>
inoremap <silent> <c-l> <c-o>:wincmd l<cr>

" Don't deselect visual block on changing indent
xnoremap < <gv
xnoremap > >gv

" Search options
set ignorecase
set smartcase
set incsearch
set hlsearch
" set nomagic "We can't set nomagic as it interferes with the Oblique plugin

" Substitute all matches on a line by default
set gdefault

" Encodings
set fileformats=unix,dos
setglobal nobomb
set encoding=utf-8
set fileencoding=utf-8

