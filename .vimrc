" Custom stuff
au BufNewFile,BufRead *.ejs set filetype=html

execute pathogen#infect()

call plug#begin('~/.vim/plugged')
" vim-plug plugins
Plug 'whatyouhide/vim-gotham'
Plug 'wakatime/vim-wakatime'
Plug 'terryma/vim-multiple-cursors'
" finish up vim plug
call plug#end()

" Based on https://github.com/skwp/dotfiles/blob/master/vimrc

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" ================ General Config ====================
set number                      "Line numbers are good
set relativenumber              "Relative line numbers are better
set backspace=indent,eol,start  "Allow backspace in insert mode
set history=1000                "Store lots of :cmdline history
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom
set gcr=a:blinkon0              "Disable cursor blink
set visualbell                  "No sounds
set autoread                    "Reload files changed outside vim

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden

"turn on syntax highlighting
syntax on
set cursorline

" ================ Search Settings  =================

set incsearch        "Find the next match as we type the search
set hlsearch         "Hilight searches by default
set viminfo='100,f1  "Save up to 100 marks, enable capital marks

" ================ Turn Off Swap Files ==============

set noswapfile
set nobackup
set nowb

" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.
" Only works all the time.

silent !mkdir ~/.vim/backups > /dev/null 2>&1
set undodir=~/.vim/backups
set undofile

" ================ Indentation ======================

set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

filetype on
filetype plugin on
filetype indent on

" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:$

set nowrap       "Don't wrap lines
set linebreak    "Wrap lines at convenient points

" ================ Folds ============================

set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

" ================ Completion =======================

set wildmode=list:longest
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif

"

" ================ Scrolling ========================

set scrolloff=8         "Start scrolling when we're 8 lines away fro  margins
set sidescrolloff=15
set sidescroll=1


" COLOR
set background=dark
colorscheme gotham
" colorscheme Tomorrow
syntax on

" STATUS
" set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)

let mapleader = ","

" let g:CommandTAcceptSelectionMap = '<C-t>'
" let g:CommandTAcceptSelectionTabMap = '<CR>'

nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

if has("mouse")
   set mouse=a
endif

if has('gui_running')
   set guifont=Source\ Code\ Pro:h12
   " set guifont=Source\ Code\ Pro\ for\ Powerline:h12
endif

set linespace=2

" easier navigation between split windows
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" escape to clear search
" nnoremap <esc> :noh<return><esc>

set shell=bash\ --login

" if exists('b:haveRemappedT')
"     finish
" endif
" let b:haveRemappedT=1
" let s:oldmap=maparg('T', 'n')
" function! s:LastTab()
"     let tab=tabpagenr()
"     tabnext
"     execute "tabmove ".tabpagenr('$')
"     execute "tabn ".tab
" endfunction
" execute 'nnoremap <buffer> T '.s:oldmap.':call <SID>LastTab()<CR>'

" map <C-n> :NERDTreeTabsToggle<CR>
" map <C-n> :NERDTreeToggle<CR>
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" autocmd vimenter * NERDTree

set clipboard=unnamed
set wildmenu

" show filename
set ls=2

" show whitespace as error
" match ErrorMsg '\s\+$'

" strip whitespace
function! <SID>StripTrailingWhitespaces()
     " Preparation: save last search, and cursor position.
     let _s=@/
     let l = line(".")
     let c = col(".")
     " Do the business:
     %s/\s\+$//e
     " Clean up: restore previous search history, and cursor position
     let @/=_s
     call cursor(l, c)
endfunction

nnoremap <Leader>w :call <SID>StripTrailingWhitespaces()<CR>
autocmd BufWritePre *.rb,*.js :call <SID>StripTrailingWhitespaces()

" edit from current working directory
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%

" WRAPPING
" set wrap
" set linebreak
" set nolist  " list disables linebreak
" set formatoptions=t1
" set textwidth=80
" set wrapmargin=0
" highlight overlength ctermbg=red ctermfg=white guibg=#592929
" match overlength /\%81v.\+/
set colorcolumn=80
au BufRead,BufNewFile *.md setlocal textwidth=80

let g:SuperTabDefaultCompletionType = "<c-x><c-o>"

" WP Mode
func! WordProcessorMode()
   setlocal formatoptions=aw2tq
   setlocal noexpandtab
   map j gj
   map k gk
   setlocal spell spelllang=en_us
   nnoremap \s eas<C-X><C-S>
   set thesaurus+=/Users/sbrown/.vim/thesaurus/mthesaur.txt
   set complete+=s
   set formatprg=par
   setlocal wrap
   setlocal linebreak
   set laststatus=0
   set foldcolumn=12
   set nonumber
   highlight! link FoldColumn Normal
endfu
com! Prose call WordProcessorMode()

func! CodeMode()
   set formatoptions=cql
   set number
   set ruler
   set laststatus=1
   set foldcolumn=0
   setlocal nospell
endfu
com! Code call CodeMode()

" show path of current file
" from DAS
cnoremap %% <C-R>=expand('%:h').'/'<cr>

" edit or view files in same directory as current file
" from DAS
map <leader>e :edit %%
map <leader>v :view %%

" make the current window big, but leave others context
" from DAS
set winwidth=84
" We have to have a winheight bigger than we want to set winminheight. But if
" " we set winheight to be huge before winminheight, the winminheight set will
" " fail.
set winheight=5
set winminheight=5
set winheight=999

" switch between the last two files
" from DAS
nnoremap <leader><leader> <c-^>

" airline
" let g:airline_powerline_fonts = 1

" RSpec.vim mappings
cnoremap Rt :call RunCurrentSpecFile()<CR>
cnoremap Rs :call RunNearestSpec()<CR>
cnoremap Rl :call RunLastSpec()<CR>
cnoremap Ra :call RunAllSpecs()<CR>

" opens search results in a window w/ links and highlight the matches command! -nargs=+ Grep execute 'silent grep! -I -r -n --exclude *.{json,pyc} . -e <args>' | copen | execute 'silent /<args>'
" shift-control-* Greps for the word under the cursor
:nmap <leader>g :Grep <c-r>=expand("<cword>")<cr><cr>

set omnifunc=syntaxcomplete#Complete

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_root_markers = ['.git']
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'

set t_Co=256

if executable("ag")
     set grepprg=ag\ --nogroup\ --nocolor
     let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

let g:ctrlp_show_hidden = 1

" close buffer without closing split
nnoremap <C-c> :bp\|bd #<CR>

" project-specific .vimrc
" set exrc
" set secure
" Plugin 'wakatime/vim-wakatime'
let g:wakatime_PythonBinary = '/usr/bin/python'
