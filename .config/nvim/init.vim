"
" Inspired by https://www.youtube.com/@NickJanetakis/search, https://github.com/nickjj/dotfiles
"
"" -----------------------------------------------------------------------------
" This config is targeted for NeoVim
" -----------------------------------------------------------------------------

" .............................................................................
" Auto install plugins
" .............................................................................
if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif


" .............................................................................
" Plugins
" .............................................................................
call plug#begin(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/plugged"'))
" Plug 'tpope/vim-surround'
Plug 'preservim/nerdtree'
Plug 'junegunn/goyo.vim'
" Plug 'jreybert/vimagit'
" Plug 'lukesmithxyz/vimling'
" Plug 'vimwiki/vimwiki'
" Plug 'bling/vim-airline'
Plug 'ap/vim-css-color'
" Add spelling errors to the quickfix list (vim-ingo-library is a dependency).
Plug 'inkarkat/vim-ingo-library' | Plug 'inkarkat/vim-SpellCheck'
" Briefly highlight which text was yanked.
Plug 'machakann/vim-highlightedyank'
" Automatically clear search highlights after you move your cursor.
Plug 'haya14busa/is.vim'
" Toggle comments in various ways.
Plug 'tpope/vim-commentary'
" Automatically set 'shiftwidth' + 'expandtab' (indention) based on file type.
Plug 'tpope/vim-sleuth'
" Highlight which character to jump to when using horizontal movement keys.
Plug 'unblevable/quick-scope'
" Atom One Dark / Light theme.
Plug 'rakr/vim-one'
" Integrate fzf with Vim.
Plug '$XDG_DATA_HOME/fzf'
Plug 'junegunn/fzf.vim'

" Show git file changes in the gutter.
Plug 'mhinz/vim-signify'

" Update spl file after dictionary update
Plug 'micarmst/vim-spellsync'

" Languages and file types.
Plug 'cakebaker/scss-syntax.vim'
Plug 'chrisbra/csv.vim'
Plug 'fatih/vim-go'
Plug 'godlygeek/tabular' | Plug 'tpope/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install' }
Plug 'othree/html5.vim'
Plug 'pangloss/vim-javascript'
Plug 'tpope/vim-git'
Plug 'vim-python/python-syntax'
Plug 'vim-ruby/vim-ruby'
call plug#end()

" -----------------------------------------------------------------------------
" Color settings
" -----------------------------------------------------------------------------

" Enable 24-bit true colors if your terminal supports it.
if (has("termguicolors"))
  " https://github.com/vim/vim/issues/993#issuecomment-255651605
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

  set termguicolors
endif

" Enable syntax highlighting.
syntax on

" Set the color scheme.
colorscheme one
set background=dark

" Spelling mistakes will be colored up red.
highlight SpellBad cterm=underline ctermbg=none "ctermfg=203 guifg=#ff5f5f
highlight SpellLocal cterm=underline ctermbg=none "ctermfg=203 guifg=#ff5f5f
highlight SpellRare cterm=underline ctermbg=none "ctermfg=203 guifg=#ff5f5f
highlight SpellCap cterm=underline ctermbg=none "ctermfg=203 guifg=#ff5f5f

hi Normal guibg=#2e3440
"hi Visual guibg=#2e3440
hi CursorLine guibg=#343a48


" -----------------------------------------------------------------------------
" Status line
" -----------------------------------------------------------------------------

" Heavily inspired by: https://github.com/junegunn/dotfiles/blob/master/vimrc
function! s:statusline_expr()
  let mod = "%{&modified ? '[+] ' : !&modifiable ? '[x] ' : ''}"
  let ro  = "%{&readonly ? '[RO] ' : ''}"
  let ft  = "%{len(&filetype) ? '['.&filetype.'] ' : ''}"
  let fug = "%{exists('g:loaded_fugitive') ? fugitive#statusline() : ''}"
  let sep = ' %= '
  let pos = ' %-12(%l : %c%V%) '
  let pct = ' %P'

  return '[%n] %f %<'.mod.ro.ft.fug.sep.pos.'%*'.pct
endfunction

let &statusline = s:statusline_expr()


" -----------------------------------------------------------------------------
" Basic Settings
"   Research any of these by running :help <setting>
" -----------------------------------------------------------------------------

let mapleader =","
" let mapleader=" "
" let maplocalleader=" "

" Use a line cursor within insert mode and a block cursor everywhere else.
"
" Using iTerm2? Go-to preferences / profile / colors and disable the smart bar
" cursor color. Then pick a cursor and highlight color that matches your theme.
" That will ensure your cursor is always visible within insert mode.
"
" Reference chart of values:
"   Ps = 0  -> blinking block.
"   Ps = 1  -> blinking block (default).
"   Ps = 2  -> steady block.
"   Ps = 3  -> blinking underline.
"   Ps = 4  -> steady underline.
"   Ps = 5  -> blinking bar (xterm).
"   Ps = 6  -> steady bar (xterm).
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

set autoindent
set autoread
set backspace=indent,eol,start
set backupdir=/tmp//,.
" set clipboard=unnamedplus,unnamed
set clipboard+=unnamedplus
"set colorcolumn=80
set complete+=kspell
set completeopt=menuone,longest
set cursorline
set directory=/tmp//,.
set encoding=utf-8
set expandtab smarttab
set formatoptions=tcqrn1
set hidden
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set matchpairs+=<:> " Use % to jump between pairs
set mmp=5000
set modelines=2
set mouse=a
set nocompatible
set noerrorbells visualbell t_vb=
set noshiftround
set nospell
set nostartofline
"set number relativenumber
set number
set regexpengine=1
set ruler
set scrolloff=0
set shiftwidth=2
set showcmd
set showmatch
set shortmess+=c
set showmode
set smartcase
set softtabstop=2
set spelllang=en_us
set splitbelow
set splitright
set tabstop=2
set textwidth=0
set ttimeout
set timeoutlen=1000
set ttimeoutlen=0
set ttyfast
if !has('nvim')
  set ttymouse=sgr
endif
set undodir=/tmp
set undofile
set virtualedit=block
set whichwrap=b,s,<,>
set wildmenu
set wildmode=full
set wrap
set nofixendofline

runtime! macros/matchit.vim

" Disables automatic commenting on newline:
" autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o



" -----------------------------------------------------------------------------
" Basic mappings
" -----------------------------------------------------------------------------

" Toggle quickfix window.
function! QuickFix_toggle()
    for i in range(1, winnr('$'))
        let bnum = winbufnr(i)
        if getbufvar(bnum, '&buftype') == 'quickfix'
            cclose
            return
        endif
    endfor

    copen
endfunction
nnoremap <silent> <Leader>c :call QuickFix_toggle()<CR>

" Toggle spell check.
"	For spell suggestions press =z.
"	To add word to dictionary press zg and to undo press zug
"
"	:SpellCheck list all miss spellings and use <leader>C to open list.
nnoremap <F5> :setlocal spell!<CR>
inoremap <F5> <C-o>:setlocal spell!<CR>

" Allow files to be saved as root when forgetting to start Vim using sudo.
command Sw :execute ':silent w !sudo tee % > /dev/null' | :edit!

" Save file as sudo on files that require root permission
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Replace all is aliased to S.
nnoremap S :%s//g<Left><Left>

" Markdown highlight
vnoremap <leader>m :s/\%V.*\%V./<mark>&<\/mark>/
" -----------------------------------------------------------------------------
" Basic autocommands
" -----------------------------------------------------------------------------

" Auto-resize splits when Vim gets resized.
autocmd VimResized * wincmd =

" Update a buffer's contents on focus if it changed outside of Vim.
au FocusGained,BufEnter * :checktime

" Unset paste on InsertLeave.
autocmd InsertLeave * silent! set nopaste

" Make sure all types of requirements.txt files get syntax highlighting.
autocmd BufNewFile,BufRead requirements*.txt set ft=python

" Make sure .aliases, .bash_aliases and similar files get syntax highlighting.
autocmd BufNewFile,BufRead .*aliases* set ft=sh

" Ensure tabs don't get converted to spaces in Makefiles.
autocmd FileType make setlocal noexpandtab

" Only show the cursor line in the active buffer.
augroup CursorLine
    au!
    au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline
augroup END

" Mappings to make Vim more friendly towards presenting slides.
autocmd BufNewFile,BufRead *.vpm call SetVimPresentationMode()
function SetVimPresentationMode()
  nnoremap <buffer> <Right> :n<CR>
  nnoremap <buffer> <Left> :N<CR>

  if !exists('#goyo')
    Goyo
  endif
endfunction

" Run xrdb whenever Xdefaults or Xresources are updated.
autocmd BufRead,BufNewFile Xresources,Xdefaults,xresources,xdefaults set filetype=xdefaults
autocmd BufWritePost Xresources,Xdefaults,xresources,xdefaults !xrdb %

" When shortcut files are updated, renew bash and ranger configs with new material:
autocmd BufWritePost bm-files,bm-dirs !shortcuts

" Automatically deletes all trailing whitespace and newlines at end of file on save. & reset cursor position
autocmd BufWritePre * let currPos = getpos(".")
autocmd BufWritePre * %s/\s\+$//e
autocmd BufWritePre * %s/\n\+\%$//e
" autocmd BufWritePre *.[ch] %s/\%$/\r/e
autocmd BufWritePre * cal cursor(currPos[1], currPos[2])

" ----------------------------------------------------------------------------
" Basic commands
" ----------------------------------------------------------------------------


" -----------------------------------------------------------------------------
" Plugin settings, mappings and autocommands
" -----------------------------------------------------------------------------

" .............................................................................
" junegunn/fzf.vim
" .............................................................................

let $FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all'

" Customize fzf colors to match your color scheme.
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-b': 'split',
  \ 'ctrl-v': 'vsplit',
  \ 'ctrl-y': {lines -> setreg('*', join(lines, "\n"))}}

" Launch fzf with CTRL+P.
nnoremap <silent> <C-p> :FZF -m<CR>

" Map a few common things to do with FZF.
nnoremap <silent> <Leader><Enter> :Buffers<CR>
nnoremap <silent> <Leader>l :Lines<CR>

" Allow passing optional flags into the Rg command.
"   Example: :Rg myterm -g '*.md'
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \ "rg --column --line-number --no-heading --color=always --smart-case " .
  \ <q-args>, 1, fzf#vim#with_preview(), <bang>0)


" .............................................................................
" unblevable/quick-scope
" .............................................................................

" Trigger a highlight in the appropriate direction when pressing these keys.
let g:qs_highlight_on_keys=['f', 'F', 't', 'T']

" Only underline the highlights instead of using custom colors.
highlight QuickScopePrimary gui=underline cterm=underline
highlight QuickScopeSecondary gui=underline cterm=underline


" .............................................................................
" micarmst/vim-spellsync
" .............................................................................

" Run SpellSync automatically when Vim starts
let g:spellsync_run_at_startup = 1

" Enable the Git union merge option
" Creates a .gitattributes file in the spell directories if one does not exist
let g:spellsync_enable_git_union_merge = 0

" Enable Git ignore for binary spell files
" Creates a .gitignore file in the spell directories if one does not exist
let g:spellsync_enable_git_ignore = 0


" .............................................................................
" junegunn/goyo.vim
" .............................................................................

" Goyo plugin makes text more readable when writing prose:
"map <leader>f :Goyo \| set bg=dark \| set linebreak \| hi Normal guibg=#2e3440 \|hi CursorLine guibg=#343a48 \|hi Visual guibg=#2e3440  <CR>
map <leader>f :Goyo <CR>

function! s:goyo_enter()
set bg=dark
set linebreak
hi Normal guibg=#2e3440
hi CursorLine guibg=#343a48
"hi LineNr guibg=#2e3440
hi VertSplit guibg=#2e3440
hi StatusLine guibg=#2e3440
hi StatusLineNC guibg=#2e3440 guifg=#2e3440
endfunction

function! s:goyo_leave()
set bg=dark
set linebreak
hi Normal guibg=#2e3440
hi CursorLine guibg=#343a48
hi LineNr guibg=#2e3440
"hi Visual guibg=#2e3440
endfunction


autocmd! User GoyoEnter call <SID>goyo_enter()
autocmd! User GoyoLeave call <SID>goyo_leave()


" -----------------------------------------------------------------------------
" Terminal Settings
" -----------------------------------------------------------------------------

autocmd TermOpen * setlocal nonumber norelativenumber
autocmd TermOpen * nnoremap <buffer> <C-c> i<C-c>
autocmd TermOpen * set noruler
autocmd TermOpen * set noshowcmd
autocmd TermOpen * set wrap
"autocmd TermOpen * set noshowmode
autocmd TermOpen * set mouse=""
autocmd TermOpen * cabbrev q <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'close' : 'q')<CR>

" Hide Terminal Bar
autocmd TermOpen * set laststatus=0

" Escape Terminal insert mode
tnoremap <C-n> <C-\><C-n>

" Change titlebar title to current command
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

" Toggle mouse input
function ToggleMouse()
    if !exists("s:old_mouse")
        let s:old_mouse = "a"
    endif

    if &mouse == ""
        let &mouse = s:old_mouse
        echo "Mouse is for Vim (" . &mouse . ")"
	set mouse=a
    else
        let s:old_mouse = &mouse
        let &mouse=""
        echo "Mouse is for terminal"
	set mouse=""
    endif
endfunction
tnoremap <F3> <C-\><C-n>:call ToggleMouse()<Enter>i
noremap <F3> :call ToggleMouse()<Enter>i
















" Set title
	set title
	"set titlestring=\ %-25.55F\ %a%r%m titlelen=70

"tnoremap <Esc> <C-\><C-n>

" Some basics:
	nnoremap c "_c
	filetype plugin on

" Perform dot commands over visual blocks:
	vnoremap . :normal .<CR>


" Spell-check set to <leader>o, 'o' for 'orthography':
	map <leader>us :setlocal spell! spelllang=en_us<CR>
	map <leader>nl :setlocal spell! spelllang=nl<CR>
	"map <leader>uk :setlocal spell! spelllang=en_uk<CR>

" Check file in shellcheck:
	map <leader>s :!clear && shellcheck -x %<CR>


" Ensure files are read as what I want:
	let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
	map <leader>v :VimwikiIndex
	let g:vimwiki_list = [{'path': '~/VimWiki', 'syntax': 'markdown', 'ext': '.md'}]
	autocmd BufRead,BufNewFile /tmp/calcurse*,~/.calcurse/notes/* set filetype=markdown
	autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
	autocmd BufRead,BufNewFile *.tex set filetype=tex

" Search keybinding
	nmap <leader>url /https\?:\/\/\(\w\+\(:\w\+\)\?@\)\?\([A-Za-z][-_0-9A-Za-z]*\.\)\{1,}\(\w\{2,}\.\?\)\{1,}\(:[0-9]\{1,5}\)\?\S*/
