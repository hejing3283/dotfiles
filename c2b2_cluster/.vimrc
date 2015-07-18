execute pathogen#infect()
syntax on
"Set Methods ---------------------{{{
  " set foldmethod=syntax
  set foldmethod=indent
  set number
  set background=dark "Make the color suitable to dark background
  set hidden "Allow modified/unsaved buffers in the background.
  set history=1000
  set nu
  set smartcase
  set ignorecase
  set shiftwidth=2
  set softtabstop=2
  set incsearch
  runtime macros/matchit.vim
  set nocompatible
  syntax on
  filetype plugin indent on
" }}}
"
" set Tlist_Ctags_Cmd=/ifs/home/c2b2/ac_lab/jh3283/.vim/bundle/ctags.vim/plugin/ctags.vim
"  Taglist
nnoremap <silent> <F7> :TlistToggle<CR>

"Movements--------------------------------------------------{{{
  nnoremap j gj
  nnoremap k gk
  xnoremap j gj
  xnoremap k gk
  "Fasta up and down
  " nmap J 5j
  nmap K 5k
  xmap J 5j
  xmap K 5k
  "Split navigation
  nmap gh <C-w>h
  nmap gj <C-w>j
  nmap gk <C-w>k
  nmap gl <C-w>l
  "Tab navigation
  nmap <C-l> gt
  nmap <C-h> gT
"Buffer navigation
  nmap <C-n> :bnext<CR>
"reselect after indenting
  vnoremap < <gv
  vnoremap > >gv
"never use Ex mode -- I never *mean* to press it
  nnoremap Q <ESC>
"Escape Mode
imap jj <Esc>
"never use F1 -- I'm reaching for escape
  noremap  <F1> <ESC>
  noremap! <F1> <ESC>
  lnoremap <F1> <ESC>
  nnoremap aa pkj
"}}}
""Keyboard shortcuts -------------------{{{
  nmap \l :setlocal number!<CR>
  nmap \q :nohlsearch<CR>
  set hlsearch "Highlight searches by default
  nmap \e :NERDTreeToggle<CR>

"insert file name : \fn in insert mode
inoremap \fn <C-R>=expand("%:t")<CR>
"Editting source files
nnoremap <Leader>ev :vsplit $MYVIMRC<CR>
nnoremap <Leader>sv :source $MYVIMRC<CR>
nnoremap <Leader>es :vsplit ~/.vim/bundle/mysnippets/snippets<CR>
"Keep search matches in the middle of the window and pulse the line when moving to them
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap vv ^vg_

"Select all
nnoremap <C-a> ggvG
inoremap <C-a> <Esc>ggvG

" Use sane regexes.
nnoremap / /\v
vnoremap / /\v

"Paste Toggle
set pastetoggle=<F8>
" Clean trailing whitespace
" nnoremap <leader>w mz:%s/\s\+$//<cr>:let @/=''<cr>`z
" " Trailing whitespace {{{
" " Only shown when not in insert mode so I don't go insane.

" augroup trailing
"     au!
"     au InsertEnter * :set listchars-=trail:⌴
" augroup END

" " }}}

"}}}

"set smartindent

"nnoremap <silent> <C-l> :nohl<CR><C-l>
inoremap <F9> <C-O>za
nnoremap <F9> za
onoremap <F9> <C-C>za
vnoremap <F9> zf

"focus current fold
nnoremap <leader>z zMzvzz

"Remapping marking pos
" nnoremap ' `
" nnoremap ` '
"save when losing focus
au FocusLost * :silent! wall


" Make sure Vim returns to the same line when you reopen a file.
" Thanks, Amit
augroup line_return
    au!
    au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \     execute 'normal! g`"zvzz' |
        \ endif
augroup END

" }}}

"Shell command --------------------------------------------------{{{
command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>)
function! s:RunShellCommand(cmdline)
  echo a:cmdline
  let expanded_cmdline = a:cmdline
  for part in split(a:cmdline, ' ')
     if part[0] =~ '\v[%#<]'
        let expanded_part = fnameescape(expand(part))
        let expanded_cmdline = substitute(expanded_cmdline, part, expanded_part, '')
     endif
  endfor
  botright new
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
  call setline(1, 'You entered:    ' . a:cmdline)
  call setline(2, 'Expanded Form:  ' .expanded_cmdline)
  call setline(3,substitute(getline(2),'.','=','g'))
  execute '$read !'. expanded_cmdline
  setlocal nomodifiable
  1
endfunction
"}}}

function! RenameFile() "{{{
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
nnoremap <Leader>n :call RenameFile()<cr>

"}}}

function! MarkWindowSwap() "{{{
  let g:markedWinNum = winnr()
  endfunction

function! DoWindowSwap()
  "Mark destination
  let curNum = winnr()
  let curBuf = bufnr( "%" )
  exe g:markedWinNum . "wincmd w"
  "Switch to source and shuffle dest->source
  let markedBuf = bufnr( "%" )
  "Hide and open so that we aren't prompted and keep history
  exe 'hide buf' curBuf
  "Switch to dest and shuffle source->dest
  exe curNum . "wincmd w"
  "Hide and open so that we aren't prompted and keep history
  exe 'hide buf' markedBuf
endfunction

nmap <silent> <leader>mw :call MarkWindowSwap()<CR>
nmap <silent> <leader>pw :call DoWindowSwap()<CR>
au BufNewFile, BufRead *.r set filetype=r
au BufNewFile, BufRead *.R set filetype=r


" WINDOW MANAGEMENT SETTINGS
"
" "moving from window to window
nnoremap <C-h>  <C-w>h
nnoremap <C-j>  <C-w>j
nnoremap <C-k>  <C-w>k
nnoremap <C-l>  <C-w>l

" "open new blank file
" nnoremap o<C-h> :lefta vsp new<cr>
" nnoremap o<C-j> :bel sp new<cr>
" nnoremap o<C-k> :abo sp new<cr>
" nnoremap o<C-l> :rightb vsp new<cr>
"
" "move window
" nnoremap <Leader><C-h> <C-W>H
" nnoremap <Leader><C-j> <C-W>J
" nnoremap <Leader><C-k> <C-W>K
" nnoremap <Leader><C-l> <C-W>L
"
" "maximise horizontally
" map <Leader>= <C-w><Bar>
"
" "maximise vertically
" map <Leader>- <C-w>_
"
" "make all windows equally sized
" map <Leader><Leader> <C-w>=
"
" "change windowsizes in visual mode
" "horizontally - always three chars else it takes ages
" vnoremap - 3<C-w><
" vnoremap = 3<C-w>>
"
" "vertically - always three chars else it takes ages
" vnoremap _ 3<C-w>-
" vnoremap + 3<C-w>+
"
" "moving from window to window in visual mode
" "that way you can move from window to window and resize with -,=,_,+
" directly as needed
" vnoremap <C-h> <ESC><C-w>hv
" vnoremap <C-j> <ESC><C-w>jv
" vnoremap <C-k> <ESC><C-w>kv
" vnoremap <C-l> <ESC><C-w>lv
