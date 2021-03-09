" Disable language server protocol in ale
"let g:ale_disable_lsp = 1

filetype plugin on    " required
" To ignore plugin indent changes, instead use:
" filetype plugin on

set nocompatible " required by vim-polyglot
let g:polyglot_disabled = ['autoindent', 'sensible']

" Required:
call plug#begin(expand('~/.config/nvim/plugged'))

"*****************************************************************************
"" Plug install packages
"*****************************************************************************
" git integration
Plug 'tpope/vim-fugitive'
" airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" parentheses
Plug 'tpope/vim-surround'
" syntax highlight
Plug 'sheerun/vim-polyglot'

" autocompletion and lsp
"Plug 'dense-analysis/ale'
" Use release branch :(Recommend)
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" indent
"Plug 'lukas-reineke/indent-blankline.nvim'

" misc
Plug 'tpope/vim-rhubarb' " required by fugitive to :Gbrowse

" themes
Plug 'crusoexia/vim-monokai'
Plug 'gruvbox-community/gruvbox'
Plug 'severij/vadelma'
Plug 'ntk148v/vim-horizon'

" extra colors
Plug 'chrisbra/Colorizer'
Plug 'ap/vim-css-color'

"Plug 'bfrg/vim-cpp-modern'

" html
Plug 'mattn/emmet-vim'

" markdown
Plug 'suan/vim-instant-markdown', {'for': 'markdown'}

" embed in browser
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }

call plug#end()

"*****************************************************************************
"" Basic Setup
"*****************************************************************************"
"" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8

" custom rc
set exrc

"" Tabs. May be overridden by autocmd rules
set tabstop=4
set softtabstop=0
set shiftwidth=4
set expandtab

"" Indentation settings
set smartindent
set autoindent

"" Searching
set hlsearch
set incsearch
set ignorecase

" extra buffers
set hidden

set noerrorbells

set colorcolumn=80

set fileformats=unix,dos,mac

if exists('$SHELL')
    set shell=$SHELL
else
    set shell=/bin/sh
endif

"*****************************************************************************
"" Visual Settings
"*****************************************************************************
syntax on
"set ruler
set number relativenumber

"let no_buffers_menu=1
colorscheme gruvbox
set background=dark

set mousemodel=popup
set t_Co=256
"set guioptions=egmrti
"set gfn=Monospace\ 10

set mouse=a          "" nicr

au TermEnter * setlocal scrolloff=0
au TermLeave * setlocal scrolloff=;


"" Status bar
"set laststatus=2

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

if exists("*fugitive#statusline")
  set statusline+=%{fugitive#statusline()}
endif

" vim-airline
let g:airline_theme = 'gruvbox'
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#coc#enabled = 1
"let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tagbar#enabled = 1
let g:airline_skip_empty_sections = 1
let g:airline_powerline_fonts = 1

"*****************************************************************************
"" Abbreviations
"*****************************************************************************
"" no one is really happy until you have this shortcuts
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall


"*****************************************************************************
"" Commands
"*****************************************************************************
" remove trailing whitespaces
command! FixWhitespace :%s/\s\+$//e

"*****************************************************************************
"" Autocmd Rules
"*****************************************************************************

" Delete trailing whitespaces on save
autocmd BufWritePre * %s/\s\+$//e
"" The PC is fast enough, do syntax highlight syncing from start unless 200 lines
"augroup vimrc-sync-fromstart
"  autocmd!
"  autocmd BufEnter * :syntax sync maxlines=200
"augroup END

""" Remember cursor position
"augroup vimrc-remember-cursor-position
"  autocmd!
"  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
"augroup END

"" txt
"augroup vimrc-wrapping
"  autocmd!
"  autocmd BufRead,BufNewFile *.txt call s:setupWrapping()
"augroup END

"" make/cmake
"augroup vimrc-make-cmake
"  autocmd!
"  autocmd FileType make setlocal noexpandtab
"  autocmd BufNewFile,BufRead CMakeLists.txt setlocal filetype=cmake
"augroup END

"set autoread

"*****************************************************************************
"" Mappings
"*****************************************************************************

" ale
let g:ale_linters = {}

" Tagbar
nmap <silent> <F4> :TagbarToggle<CR>
let g:tagbar_autofocus = 1

" Disable visualbell
set noerrorbells visualbell t_vb=
if has('autocmd')
  autocmd GUIEnter * set visualbell t_vb=
endif

"" Copy/Paste/Cut
if has('unnamedplus')
  set clipboard=unnamed,unnamedplus
endif

noremap YY "+y<CR>
noremap <leader>p "+gP<CR>
noremap XX "+x<CR>

"" Buffer nav
noremap <leader>z :bp<CR>
noremap <leader>q :bp<CR>
noremap <leader>x :bn<CR>
noremap <leader>w :bn<CR>

"" Close buffer
noremap <leader>c :bd<CR>

"" Clean search (highlight)
nnoremap <silent> <leader><space> :noh<cr>

"" Switching windows
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h

"" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

"" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv


" Make adjusing split sizes a bit more friendly
noremap <silent> <C-Left> :vertical resize +2<CR>
noremap <silent> <C-Right> :vertical resize -2<CR>
noremap <silent> <C-Up> :resize +2<CR>
noremap <silent> <C-Down> :resize -2<CR>

" set jj to esc, no language I know uses jj
:imap jj <Esc>

" coc-explorer
nmap <space>e :CocCommand explorer<CR>

"*****************************************************************************
"" Convenience variables
"*****************************************************************************

" vim-airline
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

if !exists('g:airline_powerline_fonts')
  let g:airline#extensions#tabline#left_sep = ' '
  let g:airline#extensions#tabline#left_alt_sep = '|'
  let g:airline_left_sep          = '▶'
  let g:airline_left_alt_sep      = '»'
  let g:airline_right_sep         = '◀'
  let g:airline_right_alt_sep     = '«'
  let g:airline#extensions#branch#prefix     = '⤴' "➔, ➥, ⎇
  let g:airline#extensions#readonly#symbol   = '⊘'
  let g:airline#extensions#linecolumn#prefix = '¶'
  let g:airline#extensions#paste#symbol      = 'ρ'
  let g:airline_symbols.linenr    = '␊'
  let g:airline_symbols.branch    = '⎇'
  let g:airline_symbols.paste     = 'ρ'
  let g:airline_symbols.paste     = 'Þ'
  let g:airline_symbols.paste     = '∥'
  let g:airline_symbols.whitespace = 'Ξ'
else
  let g:airline#extensions#tabline#left_sep = ''
  let g:airline#extensions#tabline#left_alt_sep = ''

  " powerline symbols
  let g:airline_left_sep = ''
  let g:airline_left_alt_sep = ''
  let g:airline_right_sep = ''
  let g:airline_right_alt_sep = ''
  let g:airline_symbols.branch = ''
  let g:airline_symbols.readonly = ''
  let g:airline_symbols.linenr = ''
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  => coc.vim settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nobackup
set nowritebackup

set cmdheight=2

set updatetime=300

set shortmess+=c

set signcolumn=yes

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Alacritty fixes Vim only
""""""""""""""""""""""""""""""""""""""""""""""""""""

if !has('nvim')
    set ttymouse=sgr
endif
