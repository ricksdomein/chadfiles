let mapleader =","

" Color scheme
colorscheme peachpuff
highlight Search term=NONE ctermbg=3 ctermfg=NONE ctermbg=8 guibg=#ffd7af
" highlight Search term=reverse ctermbg=3 ctermfg=0 guibg=Gold2
if (&background == 'dark')
  hi Visual cterm=NONE ctermfg=NONE ctermbg=8 guibg=#3a3a3a
else
  hi Visual cterm=NONE ctermfg=NONE ctermbg=8 guibg=#ffd7af
endif

" Enable Mouse
set mouse=a
" Share clipboard with mouse
set clipboard+=unnamedplus

" Search case insensitive unless capital is defined
set ignorecase
set smartcase

" Disables automatic commenting on newline:
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Hide Terminal Bar
set laststatus=0

"set noshowmode
"set noruler
"set noshowcmd
"tnoremap <Esc> <C-\><C-n>

" Some basics:
nnoremap c "_c
set nocompatible
filetype plugin on
syntax on
set encoding=utf-8
set number

" Terminal options
autocmd TermOpen * setlocal nonumber norelativenumber
autocmd TermOpen * nnoremap <buffer> <C-c> i<C-c>
autocmd TermOpen * set noruler
autocmd TermOpen * set noshowcmd
autocmd TermOpen * set wrap
"autocmd TermOpen * set noshowmode

" Escape Terminal insert mode
tnoremap <C-n> <C-\><C-n>


" Automatically deletes all trailing whitespace and newlines at end of file on save. & reset cursor position
autocmd BufWritePre * let currPos = getpos(".")
autocmd BufWritePre * %s/\s\+$//e
autocmd BufWritePre * %s/\n\+\%$//e
autocmd BufWritePre *.[ch] %s/\%$/\r/e
autocmd BufWritePre * cal cursor(currPos[1], currPos[2])
" When shortcut files are updated, renew bash and ranger configs with new material:
autocmd BufWritePost bm-files,bm-dirs !shortcuts
" Run xrdb whenever Xdefaults or Xresources are updated.
autocmd BufRead,BufNewFile Xresources,Xdefaults,xresources,xdefaults set filetype=xdefaults
autocmd BufWritePost Xresources,Xdefaults,xresources,xdefaults !xrdb %
" Save file as sudo on files that require root permission
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!
