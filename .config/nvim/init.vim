" Change leader key to ,
	let mapleader =","

" Plugins
	if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
		echo "Downloading junegunn/vim-plug to manage plugins..."
		silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
		silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
		autocmd VimEnter * PlugInstall
	endif

	call plug#begin(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/plugged"'))
	" Plug 'tpope/vim-surround'
	Plug 'preservim/nerdtree'
	Plug 'junegunn/goyo.vim'
	" Plug 'jreybert/vimagit'
	" Plug 'lukesmithxyz/vimling'
	" Plug 'vimwiki/vimwiki'
	" Plug 'bling/vim-airline'
	Plug 'tpope/vim-commentary'
	Plug 'ap/vim-css-color'
	call plug#end()

" Set title
	set title
	"set titlestring=\ %-25.55F\ %a%r%m titlelen=70

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

" Disables automatic commenting on newline:
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Perform dot commands over visual blocks:
	vnoremap . :normal .<CR>

" Goyo plugin makes text more readable when writing prose:
	map <leader>f :Goyo \| set bg=light \| set linebreak<CR>

" Spell-check set to <leader>o, 'o' for 'orthography':
	map <leader>us :setlocal spell! spelllang=en_us<CR>
	map <leader>nl :setlocal spell! spelllang=nl<CR>
	map <leader>uk :setlocal spell! spelllang=en_uk<CR>

" Check file in shellcheck:
	map <leader>s :!clear && shellcheck -x %<CR>

" Replace all is aliased to S.
	nnoremap S :%s//g<Left><Left>

" Ensure files are read as what I want:
	let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
	map <leader>v :VimwikiIndex
	let g:vimwiki_list = [{'path': '~/VimWiki', 'syntax': 'markdown', 'ext': '.md'}]
	autocmd BufRead,BufNewFile /tmp/calcurse*,~/.calcurse/notes/* set filetype=markdown
	autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
	autocmd BufRead,BufNewFile *.tex set filetype=tex

" Search keybinding
	nmap <leader>url /https\?:\/\/\(\w\+\(:\w\+\)\?@\)\?\([A-Za-z][-_0-9A-Za-z]*\.\)\{1,}\(\w\{2,}\.\?\)\{1,}\(:[0-9]\{1,5}\)\?\S*/

function! RenameTerminalBufferToCurrentCommand()
  " unable to access $HISTFILE from vim, so change this variable to your history file
  let l:historyFile = "~/.cache/zsh/history"
  let l:mostRecentCommand = system("tail -1 " . l:historyFile . " | cut -f2- -d\\;")

  " i prepend "term" for easy buffer searching, but feel free to delete
  let l:newFileName = "term " . fnameescape(trim(l:mostRecentCommand))

  " the keepalt stops :file from creating an alternative file (alt files are
  " annoying when buffer switching)
  " :file renames the buffer
  silent! execute "keepalt file " . l:newFileName

endfunction


tnoremap <Enter> <Enter><C-\><C-n>:call RenameTerminalBufferToCurrentCommand()<Enter>a
