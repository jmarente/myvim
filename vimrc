set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()

" let Vundle manage Vundle
" required!-
Plugin 'gmarik/vundle'

Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/syntastic'
Plugin 'plasticboy/vim-markdown'
Plugin 'ervandew/supertab'
Plugin 'flazz/vim-colorschemes'
Plugin 'tpope/vim-fugitive'
Plugin 'rodjek/vim-puppet'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'isRuslan/vim-es6'
Plugin 'fgsch/vim-varnish'
Plugin 'tpope/vim-commentary'
Plugin 'airblade/vim-gitgutter'
Plugin 'stephpy/vim-php-cs-fixer'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'arnaud-lb/vim-php-namespace'

call vundle#end()            " required
filetype plugin indent on    " required

" ****** Plugins config ******

" NeerdTree config
let g:nerdtree_tabs_open_on_console_startup=1
let NERDTreeIgnore = ['.vim$', '\~$', '.*\.pyc$', '.*.pid', '.*\.o$', '.*\.pyc\$class', '__pycache__']

" Airline config
set t_Co=256
set laststatus=2  " always show the status bar
let g:airline_enable_syntastic = 1
let g:airline_powerline_fonts = 1

let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_linecolumn_prefix = '␤ '
let g:airline_fugitive_prefix = '⎇ '
let g:airline_paste_symbol = 'ρ'
let g:airline_readonly_symbol = '✗'
" let g:airline_theme = 'murmur'
" let g:airline_theme = 'simple'
let g:airline_theme = 'luna'
" let g:airline_theme = 'light'

" let g:airline#extensions#tabline#enabled = 1

" Vim markdown config
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_folding_disabled = 1

" PHP-cs-fixer
let g:php_cs_fixer_path = "~/.bin/php-cs-fixer"

" SnipMate
" :let g:snips_trigger_key = '<C-tab>'
" :let g:snips_trigger_key_backwards = '<s-tab>'

" ****** Vim config *******
"
set nu " Show line number
set nowrap
set autoindent
set backupcopy=yes " keep a backup file
set viminfo='20,\"50 " read/write a .viminfo file, don't store more than 50 lines of registers
set history=100 " keep 100 lines of command line history
set ruler " show cursor position
set expandtab
set tabstop=4
set listchars=tab:>.,trail:-,extends:>,precedes:<
set list
set encoding=utf-8
set shiftwidth=4
set title
set colorcolumn=99
syntax on

" Change tab depending on file type
autocmd Filetype html setlocal ts=2 sts=2 sw=2
autocmd Filetype htmldjango setlocal ts=2 sts=2 sw=2

" Favorite color schemes

silent! colorscheme triplejelly
" silent! colorscheme benlight
" silent! colorscheme candyman
" silent! colorscheme jelleybeans
" silent! colorscheme luna-term
" silent! colorscheme made_of_color
" silent! colorscheme desertink

if exists("g:colors_name")
    if g:colors_name == 'triplejelly'
        highlight LineNr ctermfg=grey
    endif
endif



" Search
set hlsearch    " Highlight search matches
set incsearch   " incremental searching
set ignorecase  " search case insensitive...
set smartcase   " unless they contain at least one capital letter


" Maps
map <silent> <C-t> :NERDTreeToggle<CR>
map <silent> <C-J> :tabn<CR>
map <silent> <C-K> :tabp<CR>
nmap <silent> <C-N> :set invnumber<CR>
nmap <silent> <C-n><c-n> :tabe<CR>
nnoremap <C-L> :%s/\s\+$//<cr>:let @/=''<CR>:noh<CR> " Remove undesired empty spaces
map <silent> <C-d> :Files<CR>
map <silent> <C-f> :Ag<CR>

" Have Vim jump to the last position when reopening a file
autocmd BufReadPost *
\ if line("'\"") > 0 && line("'\"") <= line("$") |
\   exe "normal g`\"" |
\ endif

command PrettyJson execute "%!python -m json.tool"

" Ctags
" Open in new tab
:nnoremap <C-]> <C-w><C-]><C-w>T
set switchbuf="useopen/usetab"
" :nnoremap <silent><Leader><C-]> <C-w><C-]><C-w>T
" :nnoremap <C-]> g<C-]>
au BufWritePost *.php silent! !eval '[ -f ".git/hooks/ctags" ] && .git/hooks/ctags' &

" php-cs-fixer
autocmd BufWritePost *.php silent! call PhpCsFixerFixFile()

function! IPhpInsertUse()
    call PhpInsertUse()
    call feedkeys('a',  'n')
endfunction
autocmd FileType php inoremap <Leader>u <Esc>:call IPhpInsertUse()<CR>
autocmd FileType php noremap <Leader>u :call PhpInsertUse()<CR>
