filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
filetype plugin on

syntax on
set nu
set nocompatible

" set clipboard+=unnamed

set visualbell
set wrap
set textwidth=80
set formatoptions=qrn1

" Set standard setting for PEAR coding standards
set tabstop=4
set shiftwidth=4

" Auto expand tabs to spaces
set expandtab

" Auto indent after a {
set autoindent
set smartindent


set shiftround
set smarttab

if v:version >= 703
    set undofile
    set colorcolumn=80,+0
    set relativenumber
    set undodir=~/.vim/tmp/undo//     " undo files
    set backupdir=~/.vim/tmp/backup// " backups
    set directory=~/.vim/tmp/swap//   " swap files
    set backup                        " enable backups
    set cursorline
endif



"set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/blib/*
set wildignore+=.hg,.git,.svn                    " Version control
set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.spl                            " compiled spelling word lists
set wildignore+=*.sw?                            " Vim swap files
set wildignore+=*.DS_Store                       " OSX bullshit
set wildignore+=*.luac                           " Lua byte code
set wildignore+=blib                             " perl build
set wildignore+=local-lib                        " perl local-lib
set wildignore+=*.pyc                            " Python byte code

" Setting up bundle/kien-ctrl.vim...
nnoremap <leader>b :CtrlPBuffer<cr>
nnoremap <leader>m :CtrlPMRUFiles<cr>
let g:ctrlp_map = '<Leader>p'
let g:ctrlp_working_path_mode = 0

" Setting up bundle/NERD_tree
nnoremap <Leader>n :NERDTreeToggle<cr>

" All splitscreen stuff
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" All tab settings
nnoremap <C-t> :tabnew<cr>

" kill trailing spaces
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>
nnoremap <leader>a :Ack

if has('gui_running')
    " Don't show the toolbar
    set guioptions-=T
    set guifont=guifont=Source\ Code\ Pro:h14
    " Setup startup windows size
    set lines=60
    set columns=90
endif


" Solarized: http://ethanschoonover.com/solarized
" set term=xterm-256color
" set background=dark

" http://sgaul.de/2013/10/17/von-sublime-zu-vim-ein-um-und-einstiegsversuch/
" https://github.com/kien/ctrlp.vim
set runtimepath^=~/.vim/bundle/ctrlp.vim
nnoremap <C-p> :CtrlP<cr>
" nnoremap <D-p> <C-p> :CtrlP<cr>
