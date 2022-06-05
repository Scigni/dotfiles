"First Dowload 'plug.vim' and put in the 'autoload' directory
"curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"Then open '.vimrc' and run ':PlugInstall'.
set nocompatible
filetype plugin indent on

" COC CONFIG 
set encoding=utf-8 
set nobackup                   
set nowritebackup
set cmdheight=2
set shortmess+=c

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <Ctrl-F> to auto-fix Typescript documents 
command! -nargs=0 Tsautof :CocCommand tsserver.executeAutofix 
noremap <C-F> :Tsautof<CR>

" Use <C-l> for trigger snippet expand.
"imap <C-l> <Plug>(coc-snippets-expand)
inoremap <expr> <C-l> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"


" VIM CONFIG
set number                    " show number of each line
set cursorline                " highlight current line
set autoindent				  
set hlsearch				  " highlight search words
set ignorecase				  " searches will be case insensitive
set laststatus=2              " show status line from lighline
set showtabline=2             " always show tab bar
set expandtab				  " tabs will be always spaces
set tabstop=4                 " change tab size to 4 spaces
set shiftwidth=4              " change indentation to 4 spaces
set synmaxcol=500             " Syntax limit


" Only spell check on *_APUNTE.txt files
autocmd BufRead,BufNewFile *_APUNTE.txt 
                            \ setlocal spell spelllang=es | 
                            \ hi SpellBad cterm=underline ctermfg=red

" CTRL-L / H to next tab
nnoremap <C-L> :tabnext<CR>
nnoremap <C-H> :tabprevious<CR>

" Open File Explore on a new tab 
nnoremap <F2> :Texplore<CR>

" Open terminal on a new tab
nnoremap <F3> :tab terminal<CR>

" Auto close quotes and brackets
inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O

call plug#begin()
" The default plugin directory will be
" '~/vimfiles/plugged'

" STYLE 
Plug 'itchyny/lightline.vim'          " Light-line, Status bar
" Plug 'vim-airline/vim-airline'
Plug 'ajmwagar/vim-deus'              " Theme
Plug 'mhinz/vim-startify'             " fancy start screen
Plug 'yggdroot/indentline'            " display indentation level

" COMPLETION
Plug 'alvan/vim-closetag'             " HTML auto close tag
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'honza/vim-snippets'

" UTILS 
Plug 'haya14busa/is.vim'              " Auto clear search highlights

" Commands
" :PlugInstall         Install plugins
" :PlugUpdate          Install or update plugins
" :PlugClean           Remove unlisted plugins
" :PlugUpgrade         Update vim-plug
" :PlugStatus          Check the status of plugins

call plug#end()

" Theme and lighline config
color deus
syntax on

function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction

let g:lightline = {
      \ 'colorscheme': 'deus',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'currentfunction', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status',
      \   'currentfunction': 'CocCurrentFunction'
      \ },
      \ }
