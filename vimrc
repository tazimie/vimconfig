" ===
" === Auto load for first time uses
" ===
if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
				\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


" ===
" === Create a _machine_specific.vim file to adjust machine specific stuff, like python interpreter location
" ===

"let g:python_host_prog='/usr/bin/python2'
"let g:python3_host_prog='/usr/bin/python3'

"let g:mkdp_browser = 'chromium'


" ====================
" === Editor Setup ===
" ====================
" ===

" === System
" ===


" set clipboard=unnamedplus
let &t_ut=''
set autochdir


" ===
" === Editor behavior
" ===
" 行号
set number
"set relativenumber
set cursorline
" 设置缩进
set noexpandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
" 设置空格
set list
set listchars=tab:\|\ ,trail:▫
set scrolloff=4
set ttimeoutlen=0
set notimeout
set viewoptions=cursor,folds,slash,unix
set wrap
set tw=0
set indentexpr=
" fold
set foldmethod=indent
set foldlevel=99
set foldenable
set formatoptions-=tc
set splitright
set splitbelow
set noshowmode
set showcmd
set wildmenu
set ignorecase
set smartcase
set shortmess+=c
" set inccommand=split
set completeopt=longest,noinsert,menuone,noselect,preview
set ttyfast "should make scrolling faster
set lazyredraw "same as above
set visualbell
silent !mkdir -p ~/.g/nvim/tmp/backup
silent !mkdir -p ~/.g/nvim/tmp/undo
set backupdir=~/.g/nvim/tmp/backup,.
set directory=~/.g/nvim/tmp/backup,.
if has('persistent_undo')
	set undofile
	set undodir=~/.g/nvim/tmp/undo,.
endif
set colorcolumn=80
set updatetime=1000
set virtualedit=block
" 前光标位置
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif




" ===
" === Basic Mappings
" ===
" Set <LEADER> as <SPACE>, ; as :
"let mapleader=" "
let mapleader=" "
noremap ; :


" Folding
noremap <silent> <LEADER>o za

" Redo operations
noremap U <C-r>


" make Y to copy till the end of the line
nnoremap Y y$

" Copy to system clipboard
vnoremap Y "+y

" Indentation
nnoremap < <<
nnoremap > >>

" Search
"
" Adjacent duplicate words
"noremap <LEADER>d /\(\<\w\+\>\)\_s*\1



" find and replace
noremap \s :%s //g<left><left><left>


" find and replace
"noremap \c :NERDCommenterToggle<CR>


" Compile function
noremap \r :call CompileRunGcc()<CR>
func! CompileRunGcc()
	exec "w"
	if &filetype == 'c'
		exec "!g++ % -o %<"
		exec "!time ./%<"
	elseif &filetype == 'cpp'
		set splitbelow
		exec "!g++ -std=c++11 % -Wall -o %<"
		:sp
		:res -15
		:term ./%<
	elseif &filetype == 'java'
		exec "!javac %"
		exec "!time java %<"
	elseif &filetype == 'sh'
		:!time bash %
	elseif &filetype == 'python'
		set splitbelow
		:sp
		:term python3 %
	elseif &filetype == 'html'
		silent! exec "!".g:mkdp_browser." % &"
	elseif &filetype == 'markdown'
		exec "MarkdownPreview"
	elseif &filetype == 'tex'
		silent! exec "VimtexStop"
		silent! exec "VimtexCompile"
	elseif &filetype == 'dart'
		CocCommand flutter.run
	elseif &filetype == 'go'
		set splitbelow
		:sp :term go run .
	endif
endfunc


" ===
" === Window management
" ===
" Use <sace> + new arrow keys for moving the cursor around windows
"noremap <Tab>w <C-w>w
noremap <Tab>k <C-w>k
noremap <Tab>j <C-w>j
noremap <Tab>h <C-w>h
noremap <Tab>l <C-w>l

" Disable the default s key
noremap s <nop>
noremap S <nop>

" Opening a terminal window
noremap <tab> > :set splitbelow<CR>:split<CR>:res +10<CR>:term<CR>

" split the screens to up (horizontal), down (horizontal), left (vertical), right (vertical)
"noremap <Tab>K :set nosplitbelow<CR>:split<CR>:set splitbelow<CR>
"noremap <Tab>% :set splitbelow<CR>:split<CR>
noremap % :set nosplitright<CR>:vsplit<CR>:set splitright<CR>
"noremap Sl :set nosplitleft<CR>:vsplit<CR>:set splitleft<CR>

" ===
" === Tab management
" ===
" Create a new tab with tu
noremap <Tab><Tab> :tabe<CR>
" Move around tabs with tn and ti
noremap J :tabnext<CR>


" Resize splits with arrow keys
noremap <leader><up> :res +5<CR>
noremap <leader><down> :res -5<CR>
noremap <leader><left> :vertical resize-5<CR>
noremap <leader><right> :vertical resize+5<CR>

noremap ` ~

" Auto change directory to current dir
autocmd BufEnter * silent! lcd %:p:h


"noremap <LEADER>- :lN<CR>
"noremap <LEADER>= :lne<CR>

" ===
" === Install Plugins with Vim-Plug
" ===

call plug#begin('~/.g/nvim/plugged')

Plug 'airblade/vim-rooter' "change current root
"Plug 'jpalardy/vim-slime'


" Pretty Dress
"Plug 'Yggdroot/indentLine'
"Plug 'bling/vim-bufferline'

" Genreal Highlighter
Plug 'norcalli/nvim-colorizer.lua'
Plug 'vim-airline/vim-airline'

" File navigation
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

" Undo Tree
Plug 'mbbill/undotree'


" Editor Enhancement
Plug 'scrooloose/nerdcommenter' " in <space>cn to comment a line
Plug 'tpope/vim-surround' " type yskw' to wrap the word with '' or type cs'` to change 'word' to `word`
Plug 'junegunn/vim-easy-align' " gaip= to align the = in paragraph,
Plug 'easymotion/vim-easymotion'
Plug 'svermeulen/vim-subversive'
"Plug 'preservim/nerdtree'

Plug 'AndrewRadev/splitjoin.vim' "merge&split
" Bookmarks

" Vim Applications
Plug 'itchyny/calendar.vim'

"Plug 'mattn/emmet-vim'

Plug 'mhinz/vim-startify'

" Other visual enhancement
Plug 'ryanoasis/vim-devicons'
"Plug 'wincent/terminus'
" Other useful utilities

Plug 'jiangmiao/auto-pairs'
Plug 'dracula/vim', { 'as': 'dracula' }

"Plug 'tmhedberg/SimpylFold', { 'for' :['python', 'vim-plug'] }

"Plug 'honza/vim-snippets'
"Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

" experimental
set lazyredraw
"set regexpengine=1


" ===
" === Dress up my vim
" ===
set termguicolors " enable true colors support
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

"packadd! dracula
colorscheme dracula

"hi NonText ctermfg=gray guifg=grey10

" ===================== Start of Plugin Settings =====================

let g:fzf_preview_window = 'right:60%'
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.7 } }

" ===
" === vim-splitjoin
" ===
nnoremap <leader>s gS<CR>
nnoremap <leader>j gJ<CR>



" ===
" === Undotree
" ===
noremap <leader>u :UndotreeToggle<CR>
let g:undotree_DiffAutoOpen = 1
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_ShortIndicators = 1
let g:undotree_WindowLayout = 2
let g:undotree_DiffpanelHeight = 8
let g:undotree_SplitWidth = 24



" ===
" === Colorizer
" ===
let g:colorizer_syntax = 1


" ===
" === vim-easymotion
" ===
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_do_shade = 0
let g:EasyMotion_smartcase = 1
map <leader>f <Plug>(easymotion-bd-f)
nmap <leader>f <Plug>(easymotion-bd-f)


" ===
" === vim-easy-align
" ===
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)



" ===
" === vim-rooter
" ===
let g:rooter_patterns = ['__vim_project_root', '.git/']


