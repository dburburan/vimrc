set nocompatible

"-----------------------------------------------------------------------------
" Encodings
"-----------------------------------------------------------------------------

set encoding=utf-8
set fileencoding=utf-8
set fileformats=unix,dos
setglobal nobomb

"-----------------------------------------------------------------------------
" Mapping setup
"-----------------------------------------------------------------------------

let mapleader = "'"
let s:ctrl_mapleader = "<c-'>"

" Useful map mode (normal, visual, operator-pending) same as noremap but without select mode
" Allows overwriting by typing to work when selecting (shift+move in insert mode)
command! -nargs=* -complete=mapping NXOnoremap nnoremap <args>|xnoremap <args>|onoremap <args>
command! -nargs=* -complete=mapping NXOmap nmap <args>|xmap <args>|omap <args>

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
nnoremap <leader><leader>q :Bdelete<cr>
nnoremap <leader><leader>q! :Bdelete!<cr>

" Indent object, for commands like vii, etc

" vim-repeat: Repeat plugin commands with '.'

" vim-surround: add parentheses, quotes, etc, around selections
" These mappings lose the default substitute command, but it's so similar to c for change
let g:surround_indent=0
let g:surround_no_mappings=1
nmap ds <Plug>Dsurround
nmap cs <Plug>Csurround
nmap cS <Plug>CSurround
nmap s  <Plug>Ysurround
"nmap S  <Plug>YSurround
nmap ss <Plug>Yssurround
nmap sS <Plug>YSsurround
xmap s  <Plug>VSurround
xmap gs <Plug>VgSurround

" vim-commentary
" Use single line style for cpp
autocmd FileType cpp setlocal commentstring=//%s
autocmd FileType haxe setlocal commentstring=//%s

" vim-fugitive: git wrapper

" Optionally- YouCompleteMe for completion

" vim-indentwise: indent based motions
" (customised vim-indentwise to expose the following 2 functions)
" map <c-j> <Plug>(IndentWiseNextLesserEqualIndent)
" map <c-k> <Plug>(IndentWisePreviousLesserEqualIndent)
" map <c-l> <Plug>(IndentWiseNextUnequalIndent)
" map <c-h> <Plug>(IndentWisePreviousLesserIndent)

" vim-easy-align:
xmap <Enter> <Plug>(LiveEasyAlign)
nmap ga <Plug>(LiveEasyAlign)

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

" Easymotion
let g:EasyMotion_do_mapping=1
let g:EasyMotion_smartcase = 1
let g:EasyMotion_smartsign = 1
let g:EasyMotion_use_smartsign_us = 1
" let g:EasyMotion_use_upper = 1
let g:EasyMotion_keys = 'jfhgkdielsmvurnbyt,c.x/zwoa;JFHGKDIELSMVURNBYT<C>X?ZWOA:'
let g:EasyMotion_startofline = 0
NXOmap <leader>f  <Plug>(easymotion-f)
NXOmap <leader>F  <Plug>(easymotion-F)
NXOmap <leader>t  <Plug>(easymotion-t)
NXOmap <leader>T  <Plug>(easymotion-T)
NXOmap <leader>w  <Plug>(easymotion-w)
NXOmap <leader>W  <Plug>(easymotion-W)
NXOmap <leader>q  <Plug>(easymotion-b)
NXOmap <leader>Q  <Plug>(easymotion-B)
NXOmap <leader>e  <Plug>(easymotion-e)
NXOmap <leader>E  <Plug>(easymotion-E)
NXOmap <leader>ge <Plug>(easymotion-ge)
NXOmap <leader>gE <Plug>(easymotion-gE)
NXOmap <leader>j  <Plug>(easymotion-j)
NXOmap <leader>k  <Plug>(easymotion-k)
NXOmap <leader>n  <Plug>(easymotion-n)
NXOmap <leader>N  <Plug>(easymotion-N)
NXOmap f <Plug>(easymotion-bd-f)
" NXOmap f <Plug>(easymotion-bd-fl)
" NXOmap F <Plug>(easymotion-bd-fl)
" NXOmap t <Plug>(easymotion-tl)
NXOmap F <Plug>(easymotion-bd-jk)
NXOmap T <Plug>(easymotion-bd-Tl)
" NXOmap s <Plug>(easymotion-s2)
" nmap S <Plug>(easymotion-overwin-f2)
NXOmap " <Plug>(easymotion-next)
NXOmap : <Plug>(easymotion-prev)

" Jump to anywhere
" NXOmap F <Plug>(easymotion-bd-jk)
NXOmap t <Plug>(easymotion-jumptoanywhere)
let g:EasyMotion_re_anywhere = '\v' .
  \ '([[:punct:]])(\1.)@<!' . '|' .
  \ '(<.|^$)' . '|' .
  \ '(\l\zs\u)'
  " \ '(.>|^$)' . '|' .

" Experimenting with this
" NXOmap t  <Plug>(easymotion-jumptoanywhere)

" vim-sneak
" not currently using this, easymotion instead
" NXOmap s <Plug>Sneak_s
" NXOmap S <Plug>Sneak_S
" NXOmap f <Plug>Sneak_f
" NXOmap F <Plug>Sneak_F
" NXOmap t <Plug>Sneak_t
" NXOmap T <Plug>Sneak_T
" NXOmap " <Plug>SneakNext
" NXOmap : <Plug>SneakPrevious

" Unite
"call unite#filters#matcher_default#use(['matcher_fuzzy'])
"call unite#filters#sorter_default#use(['sorter_rank'])
"call unite#custom#source('buffer,file,file/new,file_rec,file_rec/async', 'matchers', 'matcher_fuzzy')
"call unite#custom#source('buffer,file,file/new,file_rec,file_rec/async', 'matchers', 'matcher_context')
call unite#custom#source('buffer,file,file/new,file_rec', 'matchers', 'matcher_context')
"call unite#custom#source('buffer,file,file_rec,file_rec/async,line', 'sorters', 'sorter_selecta')
call unite#custom#source('buffer,file,file_rec', 'sorters', 'sorter_rank')
" call unite#custom#source('file_rec/async','sorters','sorter_rank', )
" replacing unite with ctrl-p
" let g:unite_enable_start_insert=1
call unite#filters#converter_default#use(["converter_relative_word"])
let g:unite_source_history_yank_enable=1
let g:unite_prompt='» '
let g:unite_split_rule = 'botright'
"let g:unite_split_rule = 'dynamicbottom'
"let g:unite_split_rule = 'belowright'
" let g:unite_source_rec_async_command = ['gfind']
"if executable('ag')
"  let g:unite_source_grep_command='ag'
"  let g:unite_source_grep_default_opts='--nocolor --nogroup -S -C4'
"  let g:unite_source_grep_recursive_opt=''
"endif
function! s:unite_keybindings()
  inoremap <buffer> <silent> <esc> <esc>`^
  inoremap <buffer> <silent> <c-cr> <esc>`^
  imap <buffer> <c-j> <Plug>(unite_select_next_line)
  imap <buffer> <c-k> <Plug>(unite_select_previous_line)
  imap <buffer> <c-d> <Plug>(unite_select_next_page)
  imap <buffer> <c-e> <Plug>(unite_select_previous_page)
  noremap <buffer> <c-j> j
  noremap <buffer> <c-k> k
  imap <buffer> <esc> <c-u><bs>
  map <buffer> <esc> <Plug>(unite_all_exit)
  imap <buffer> <c-cr> <Plug>(unite_do_default_action)
endfunction
autocmd FileType unite call s:unite_keybindings()

" The async version is better but requires vimproc:
" nnoremap <silent> <c-p> :Unite -auto-resize file file_rec/async -buffer-name=unitefiles -resume -start-insert -no-restore -input=<cr>

nnoremap <silent> <c-p>     :Unite                   file file_rec file/new                                 -auto-resize -start-insert -buffer-name=unite_files      -resume -no-restore -input=<cr>
nnoremap <silent> <a-p>h    :Unite                   file file_rec:/HaxeToolkit/haxe/ -path=C:/HaxeToolkit/ -auto-resize -start-insert -buffer-name=unite_haxe_files -resume -no-restore -input=<cr>
nnoremap <silent> <a-p>     :UniteWithInputDirectory file file_rec                                          -auto-resize -start-insert<cr>
nnoremap <silent> <c-f>     :Unite                   line                                                   -auto-resize -start-insert<cr>
nnoremap <silent> <c-space> :Unite                   tab buffer                                             -auto-resize -start-insert<cr>

" let g:unite_alt_sources="file:/HaxeToolkit/haxe"
" " file_rec:/HaxeToolkit/haxe"
" function StartAlternateUnite()
" endfunction
" nnoremap <silent> <a-p> :call StartAlternateUnite()<cr>

" Language Specific
" -----------------
" Coffeescript syntax highlighting

" Vaxe for haxe highlighting
let g:vaxe_completion_require_autowrite = 0

" Racket
let g:paredit_mode=0

"-----------------------------------------------------------------------------
" GUI Options
"-----------------------------------------------------------------------------
" No scrollbars
set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R
set guioptions-=h

set guioptions-=e "No GUI tab pages
set guioptions-=T "No toolbar
set guioptions-=m "No menu

if has("gui_macvim")
  set guifont=Inconsolata:h12
  command! -nargs=1 Fontsize set guifont=Inconsolata:h<args>
else
  set guifont=Inconsolata:h12:cANSI
  command! -nargs=1 Fontsize set guifont=Inconsolata:h<args>:cANSI
endif

" Allow quickly setting font size with command
cnoreabbrev fs Fontsize

if has("gui_running")
  set lines=59
  set columns=135
endif

"-----------------------------------------------------------------------------
" Options we always want
"-----------------------------------------------------------------------------

set shortmess+=I
set hidden "hidden buffers
set virtualedit+=block
set whichwrap+=h,l,<,>,[,]
set noswapfile
set wildmode=longest,list,full
set wildmenu
set ruler
set number

"-----------------------------------------------------------------------------
" Syntax Highlighting
"-----------------------------------------------------------------------------

let g:solarized_italic=0

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

let s:gui_base02   = "#073642"

" TODO: Deal with high contrast mode and inverted mode
function! ColorschemeDarkNormal()
  set background=dark
  let g:solarized_contrast="normal"
  colorscheme solarized

  let s:red = "#DC322F"
  call PostColorschemeTweak()

  let s:base03       = "#0f0f0f"
  let s:gui_base02   = "#073642"
  let s:cterm_base02 = "0"

  " Less in-your-face invisible characters
  exe "hi! SpecialKey gui=none guibg=bg guifg=" .s:gui_base02 ." ctermfg=" .s:cterm_base02
  exe "hi! NonText    gui=none guibg=bg guifg=" .s:gui_base02 ." ctermfg=" .s:cterm_base02

  exe "hi! folded guibg=" .s:base03
  hi! search gui=none guibg=#102430
endfunction

function! ColorschemeLightNormal()
  set background=light
  let g:solarized_contrast="normal"
  colorscheme solarized

  let s:red = "#DC322F"
  call PostColorschemeTweak()
endfunction

function! ColorschemeDarkContrast()
  set background=dark
  let g:solarized_contrast="high"
  colorscheme solarized

  let s:red = "#FF3936"
  call PostColorschemeTweak()
endfunction

function! ColorschemeLightContrast()
  set background=light
  let g:solarized_contrast="high"
  colorscheme solarized

  let s:red = "#FF3936"
  call PostColorschemeTweak()
endfunction

function! PostColorschemeTweak()
  " Distinguish matched parens from cursor better
  hi! MatchParen gui=bold,underline guibg=bg

  " Set User1 colour for use in status line
  exe "hi User1 ctermfg=red gui=reverse guifg=" .s:red ." guibg=" .s:gui_base02

  " Language specific
  exe "hi schemeDelimiter ctermfg=12 guifg=" .s:red ." gui=bold"
endfunction

syntax on
call ColorschemeDarkNormal()

cnoreabbrev dn call ColorschemeDarkNormal()
cnoreabbrev dc call ColorschemeDarkContrast()
cnoreabbrev coldn call ColorschemeDarkNormal()
cnoreabbrev coldc call ColorschemeDarkContrast()
cnoreabbrev colln call ColorschemeLightNormal()
cnoreabbrev collc call ColorschemeLightContrast()

" Debugging
function! SyntaxItem()
  return synIDattr(synID(line("."),col("."),1),"name")
endfunction
command! SyntaxDebug set statusline+=\ %{SyntaxItem()}

"-----------------------------------------------------------------------------
" Modifying Default Vim Behaviour
"-----------------------------------------------------------------------------

set timeoutlen=1000

" Faster Ex mode access
NXOnoremap ; :
" As a result, provide new mappings for search by character (now search back/forwards by pressing shift+: / shift+" ~ these are positionally related)
" (not in use - see mappings in EasyMotion section)
" NXOnoremap : ,
" NXOnoremap " ;
" And as a result of that, provide mappings for using registers, which is also more convenient
NXOnoremap \ "
" We use ' as our <leader>, so clear it from any other purpose
NXOnoremap ' <esc>
" We've clobbered the ability to jump to mark-line ('), now we're gonna make it (~) and jump to mark-exact will become (,)
NXOnoremap ~ '
NXOnoremap , `
" Now that we've clobbered change case (~) it will become (`)
NXOnoremap ` ~

" Adjust everything to maintain the concept of placing the cursor after an edit, instead of on top of the edit
" And that an edit is by default an insert (before current cursor location), not an add
set virtualedit+=onemore
NXOnoremap p gP
NXOnoremap P gp
NXOnoremap o O
NXOnoremap O o

" Don't move the cursor on visual mode yank
xnoremap y ygv<esc>

" Come out of insert mode assuming it was insert mode not add mode
" Also map ctrl+enter to esc
inoremap <esc> <esc>`^
" inoremap <c-cr> <esc>`^

" Ctrl+enter easier to press than escape
" noremap <c-cr> <esc>

" Make enter an alternative to line object. Pressing d<cr> or y<cr> for example much faster than dd or yy
onoremap <cr> _

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

" Scroll from home row
NXOnoremap <c-k> <c-y>
NXOnoremap <c-j> <c-e>

" Make arrow keys useful for scrolling document when you're not really editing
NXOnoremap <up> <c-y>k
NXOnoremap <down> <c-e>j

" Map H and L to Home and End, lose top of screen / bottom of screen movements which we never use anyway
NXOnoremap H g^
NXOnoremap L g$
" If we're in the middle of a motion use the whole line
onoremap H ^
onoremap L $

" Jump around surroundings from home row
NXOnoremap S %

" Map K to split line before the current word
" Should be more or less the inverse of J, we lose help-under-cursor which isn't useful anyway
nnoremap K gea<cr><esc>`^

" remap gn and gN because these are essentially text objects
onoremap in gn
onoremap iN gN
xnoremap in <esc>gn
xnoremap iN <esc>gN

" Change w and q to jump over punctuation, and be more customisable
function! GotoPattern_4dFuJoHLIE(dir, vmode) range
  let l:count = v:count1
  if a:vmode ==# 'v'
    normal! gv
  endif
  let g:_saved_search_reg = @/
  let l:flags = "W"
  if a:dir == "b"
    let l:flags .= "b"
  endif
  for i in range(l:count)
    call search('\v' . g:wordjump_regex, l:flags)
  endfor
  let @/ = g:_saved_search_reg
endfunction
nnoremap <silent> w :<c-u>call GotoPattern_4dFuJoHLIE('f', 'n')<CR>
xnoremap <silent> w :<c-u>call GotoPattern_4dFuJoHLIE('f', 'v')<CR>
nnoremap <silent> q :<c-u>call GotoPattern_4dFuJoHLIE('b', 'n')<CR>
xnoremap <silent> q :<c-u>call GotoPattern_4dFuJoHLIE('b', 'v')<CR>
command! -nargs=1 Wj let g:wordjump_regex='<args>'
cnoreabbrev wj Wj
cnoreabbrev wjd Wj <\w
let g:wordjump_regex='<\w'

"-----------------------------------------------------------------------------
" Insert mode
"-----------------------------------------------------------------------------

inoremap <c-j> <c-o>gj
inoremap <c-k> <c-o>gk
" inoremap <silent> <c-l> <c-o>:<c-u>call GotoPattern_4dFuJoHLIE('f', 'n')<CR>
" inoremap <silent> <c-h> <c-o>:<c-u>call GotoPattern_4dFuJoHLIE('b', 'n')<CR>
inoremap <c-l> <right>
inoremap <c-h> <left>

"-----------------------------------------------------------------------------
" Windows Keys (Notepad mode!)
"-----------------------------------------------------------------------------

behave mswin

" Select all. Lose increment number
noremap <c-a> ggvG$
inoremap <c-a> <c-home><c-s-end>
snoremap <c-a> <c-home><c-s-end>

" Copy, cut, paste. Lose decrement number and visual block mode, but provide alternative
noremap <c-x> "+d
nnoremap <c-c> "+y
xnoremap <c-c> "+ygv
snoremap <c-c> <c-o>"+ygv<c-g>
inoremap <c-c> <nop>
noremap <c-v> "+gP
cnoremap <c-v> <c-r>+
inoremap <c-v> <c-g>u<c-o>"+gP
" Paste mapped over insert raw character (c-v), use c-e instead
inoremap <c-e> <c-v>

" Undo and redo. We lose c-y for scrolling, but I never really used it
noremap <c-z> u
inoremap <c-z> <c-o>u
noremap <c-y> <c-r>
inoremap <c-y> <c-o><c-r>

" Provide alternative way to access visual block mode
xnoremap v <c-v>

" Indent with tab key
snoremap <tab> <c-o>>gv<c-g>
snoremap <s-tab> <c-o><gv<c-g>

"-----------------------------------------------------------------------------
" Tab Pages
"-----------------------------------------------------------------------------

noremap <c-tab> gt
noremap <c-s-tab> gT
inoremap <c-tab> <c-o>gt
inoremap <c-s-tab> <c-o>gT
" noremap <silent> <c-t> :tabedit | tabmove -1<cr>
noremap <silent> <c-t> :tabedit<cr>

" If this is the last window in the tab, then close and make the tab to its left the current
function! <sid>CloseWindow()
  if winnr('$') ==# 1
    tabmove -1
    wincmd q
  else
    wincmd q
  endif
endfunction
noremap <silent> <c-w><c-q> :call <sid>CloseWindow()<cr>
noremap <silent> <c-w>q :call <sid>CloseWindow()<cr>

" Moving
nnoremap <expr> <c-h> ":<c-u>tabmove -" .v:count1 ."<cr>"
nnoremap <expr> <c-l> ":<c-u>tabmove +" .v:count1 ."<cr>"

" Plugin: taboo.vim
let g:taboo_tab_format=" %m%f%U "
let g:taboo_renamed_tab_format=" %m[%l]%U "
cnoreabbrev t TabooRename

"-----------------------------------------------------------------------------
" Convenience Shortcuts
"-----------------------------------------------------------------------------
" Lambda symbol
inoremap <leader><tab>l <c-k>l*
" Lozenge symbol
inoremap <leader><tab>o <c-k>LZ

" Saving
cnoreabbrev w up
noremap <silent> <c-s> :up<cr>
inoremap <silent> <c-s> <esc>`^:up<cr>

" Make space center screen on cursor
NXOnoremap <space> zz
inoremap <c-space> <c-o>zz

" Select pasted text
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

" Moving blocks of text around, requires vim-unimpaired
" nmap <c-j> [<space>
" nmap <c-k> ]<space>
" vmap <c-j> ]egv=gv
" vmap <c-k> [egv=gv

" Turns out these ones clash with <c-i>
" nnoremap <s-tab> mm<<`m
" nnoremap <tab> mm>>`m
" vnoremap <s-tab> <gv
" vnoremap <tab> >gv

" nnoremap <c-j> :m .+1<cr>==
" nnoremap <c-k> :m .-2<cr>==
" inoremap <c-j> <esc>:m .+1<cr>==gi
" inoremap <c-k> <esc>:m .-2<cr>==gi

" Repair file with mixed up newline encodings
function! RepairFileNewlines()
  %s/\v^\n//
  %s/\v([^\r])\n/\1/
  %s/\v\r//
endfunction
cnoreabbrev fffix call RepairFileNewlines()

" Change current dir to current file
cnoreabbrev cdc cd %:p:h

" Buffer copy and paste
nnoremap <silent> <leader>bc :let g:bufferclip=bufnr('%')<cr>
nnoremap <silent> <leader>bv :execute "b ".g:bufferclip<cr>

" Execute line under cursor as Ex command
nnoremap <leader><leader>x :execute getline(".")<cr>

function! SerializeString(str)
  let l:str = substitute(a:str,'\\','\\\\','g')
  let l:str = substitute(l:str,'"','\\"','g')
  let l:str = substitute(l:str,'\n','\\n','g')
  let l:str = substitute(l:str,'\t','\\t','g')
  return '"' .l:str .'"'
endfunction

" Session shortcuts
" set ssop+=blank
" set ssop-=buffers
" set ssop-=curdir
" set ssop-=globals
" set ssop-=options
" set ssop+=sesdir
" set ssop+=slash
" set ssop+=tabpages
" set ssop+=unix
" set ssop+=winsize
set ssop=blank,sesdir,slash,tabpages,unix,winsize
function! SaveSession()
  mksession! session.vim

  " Plugin: taboo.vim
  call writefile([
      \'let SessionLoad = 1',
      \'let g:Taboo_tabs = ' .SerializeString(g:Taboo_tabs),
      \'doautoall SessionLoadPost',
      \'unlet SessionLoad'
    \], "session.vim", "a")

  call writefile([getcwd()], $HOME."/.vimsession")
  echo "Session saved."
endfunction
function! LoadSessionRecent()
  for path in readfile($HOME."/.vimsession", '', 1)
    execute 'cd' fnameescape(path)
  endfor
  source session.vim
endfunction
cnoreabbrev ss call SaveSession()
cnoreabbrev sl source session.vim
cnoreabbrev slr call LoadSessionRecent()

" Diff
NXOnoremap <leader>d :call ToggleDiff()<cr>
NXOnoremap <leader>do :diffoff!<cr>
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
" 'Refresh' diff
NXOnoremap <leader>r :diffupdate<cr>

"Using plugin vim-diffa to process git diff output
let g:diffa#unified#arguments = ['diff', '--no-index', '--patience', '--no-color', '--no-ext-diff', '--unified=0']

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

" Tab/indent setup
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
"noremap <silent> <c-h> :wincmd h<cr>
"noremap <silent> <c-j> :wincmd j<cr>
"noremap <silent> <c-k> :wincmd k<cr>
"noremap <silent> <c-l> :wincmd l<cr>
"inoremap <silent> <c-h> <c-o>:wincmd h<cr>
"inoremap <silent> <c-j> <c-o>:wincmd j<cr>
"inoremap <silent> <c-k> <c-o>:wincmd k<cr>
"inoremap <silent> <c-l> <c-o>:wincmd l<cr>

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


