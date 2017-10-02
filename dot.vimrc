" Install vim-plug if it's missing
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" Color Schemes
Plug 'junegunn/seoul256.vim'
Plug 'zeis/vim-kolor'
Plug 'reedes/vim-colors-pencil'
Plug 'w0ng/vim-hybrid'
Plug 'sickill/vim-monokai'

" Navigation
Plug 'christoomey/vim-tmux-navigator'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'qpkorr/vim-bufkill'
Plug 'scrooloose/nerdtree'
Plug 'haya14busa/incsearch.vim'

" Misc
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'editorconfig/editorconfig-vim'
Plug 'terryma/vim-expand-region'
Plug 'tpope/vim-surround'
Plug 'tfnico/vim-gradle'

" Language and syntax support
Plug 'fatih/vim-go'
Plug 'hynek/vim-python-pep8-indent'
Plug 'chase/vim-ansible-yaml'
Plug 'smerrill/vcl-vim-plugin'
Plug 'hashivim/vim-terraform'
Plug 'dag/vim-fish'
Plug 'sheerun/vim-polyglot'

if has('nvim') || v:version >= 800
    Plug 'w0rp/ale'
endif

call plug#end()

" Map the leader to space
let mapleader = "\<Space>"

" Various settings
syntax on
set hidden
set backspace=eol,start,indent
set smarttab
set scrolljump=10
set ruler

set lazyredraw
set synmaxcol=256
syntax sync minlines=256

filetype plugin indent on

set wildmode=list:longest,full

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("termguicolors"))
    set termguicolors
    set title
  endif
endif

" Reload .vimrc upon changes
augroup myvimrc
    au!
    au BufWritePost init.vim,.vimrc so $MYVIMRC
augroup END

" reload editorconfig when file changes
augroup editorconfig
    au!
    au BufWritePost .editorconfig EditorConfigReload
augroup END

" remove traling whitespaces - http://vim.wikia.com/wiki/Remove_unwanted_spaces
autocmd FileType c,cpp,java,php,python,sh autocmd BufWritePre <buffer> :%s/\s\+$//e

" Kill the buffer without closing window
map <C-d> :BD<cr>

" Switch to alternate file
nnoremap <silent> <leader>n :bnext<CR>
nnoremap <silent> <leader>p :bprevious<CR>

silent! nmap <leader>t :NERDTreeToggle<CR>

" Incsearch
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" Easier resizing of splits
nnoremap <silent> <Leader>+ :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 2/3)<CR>

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_user_command = ['ag %s --files-with-matches -g ""']
let g:ctrlp_user_command += ['.git', 'sh -c "cd %s && git ls-files -co --exclude-standard"']

let NERDTreeIgnore = ['\.pyc$']

if has('gui')
    set guifont=Iosevka:h15
    set macthinstrokes
    set guioptions=egm

    set background=light
    colo macvim
else
    set background=dark
    colo default

    set mouse=
end

if !isdirectory($HOME.'/.vim/swaps')
    silent call mkdir ($HOME.'/.vim/swaps', 'p')
endif

set directory=~/.vim/swaps
if exists("&undodir")
    if !isdirectory($HOME.'/.vim/undo')
        silent call mkdir ($HOME.'/.vim/undo', 'p')
    endif

    set undodir=~/.vim/undo
endif
set undofile

set laststatus=2
