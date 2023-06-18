" 
"  __  __       _   _         __     ___           
" |  \/  |_   _| \ | | ___  __\ \   / (_)_ __ ___  
" | |\/| | | | |  \| |/ _ \/ _ \ \ / /| | '_ ` _ \ 
" | |  | | |_| | |\  |  __/ (_) \ V / | | | | | | |
" |_|  |_|\__, |_| \_|\___|\___/ \_/  |_|_| |_| |_|
"         |___/                                    
"
" =================================================
"

set relativenumber
set number
set scrolloff=12
set expandtab
set smarttab
set shiftwidth=2
set tabstop=2
" Linebreak on 500 characters
set linebreak
set textwidth=500
set autoindent
set smartindent 
set wrap 
set cursorline
set ignorecase
set history=500

" Turn on the Wild menu
set wildmenu

set nobackup
set nowb
set noswapfile

set background=dark

" Enable filetype plugins
filetype plugin on
filetype indent on


function! VisualSelection(direction, extra_filter) range
  let l:saved_reg = @"
  execute "normal! vgvy"

  let l:pattern = escape(@", "\\/.*'$^~[]")
  let l:pattern = substitute(l:pattern, "\n$", "", "")

  if a:direction == 'gv'
    call CmdLine("Ack '" . l:pattern . "' " )
  elseif a:direction == 'replace'
    call CmdLine("%s" . '/'. l:pattern . '/')
  endif

  let @/ = l:pattern
  let @" = l:saved_reg
endfunction

""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.  If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support (see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

" Specify the behavior when switching between buffers 
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Plugins
call plug#begin('~/.local/share/nvim/plugged')
Plug 'dhruvasagar/vim-table-mode'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'mxw/vim-jsx'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'preservim/NERDTree'
" Press `+` to expand the visual selection and `_` to shrink it
Plug 'terryma/vim-expand-region'
Plug 'tmux-plugins/vim-tmux'
Plug 'tpope/vim-surround'
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
" Plug 'morhetz/gruvbox'
Plug 'sainnhe/sonokai'
Plug 'jiangmiao/auto-pairs'
call plug#end()

let g:coc_global_extensions = [
  \ 'coc-tsserver'
  \ ]

" Enable 256 colors palette in Gnome Terminal
if $COLORTERM == 'gnome-terminal'
  set t_Co=256
endif

" https://github.com/morhetz/gruvbox/issues/85
try
  colorscheme sonokai
catch
endtry

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gr <Plug>(coc-references)

" Move a line or lines of text using Control+[jk] 
nmap <C-j> mz:m+<cr>`z
nmap <C-k> mz:m-2<cr>`z
vmap <C-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <C-k> :m'<-2<cr>`>my`<mzgv`yo`z

" Return to last edit  when opening files (You want this!)
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear

" Set to auto read when a file is changed from the outside
set autoread
autocmd FocusGained,BufEnter * checktime

