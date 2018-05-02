" vim configuration file
" 2014-10-29

" Screw the old vim
set nocompatible

set t_Co=256

" Vundle thing

set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'Valloric/YouCompleteMe'
" Plugin 'scrooloose/syntastic'
Plugin 'leafgarland/typescript-vim'
Plugin 'derekwyatt/vim-scala'
call vundle#end()            " required
filetype plugin indent on    " required

set encoding=utf-8

" Make ycm less verbose

let g:ycm_show_diagnostics_ui = 1
let g:ycm_enable_diagnostic_signs = 0
let g:ycm_enable_diagnostic_highlighting = 1

" OSX backspace fix
set backspace=2

" Indenting
"set autoindent
set smartindent

set nojoinspaces

set invlist
set listchars=tab:>-,nbsp:_

set tags=tags;/

set history=5000
set ruler

set backup
set backupdir=~/tmp

" Background buffers on
set hidden

" My background is black so make text brighter
colorscheme slate
"colorscheme default

set visualbell

"set shiftwidth=4
"set tabstop=4
"set expandtab

syntax on
filetype plugin on

" Better searching
set hlsearch
set incsearch

set showmatch

" System clipboard
set clipboard+=unnamed
set clipboard+=unnamedplus

" Line numbers
"set number

" Language specific goodies

let yacc_uses_cpp = 1
let c_gnu = 1
let c_space_errors = 1

let c_minlines=10000

let java_highlight_all=1
let java_highlight_debug=1

let java_ignore_javadoc=1
let java_highlight_functions=1
let java_mark_braces_in_parens_as_errors=1

let html_use_css = 1

function Set_Tabs(n)
	let &tabstop=a:n
	let &shiftwidth=a:n
	set noexpandtab
endfunction

function Set_No_Tabs(n)
	let &tabstop=a:n
	let &shiftwidth=a:n
	set expandtab
endfunction

au BufNewFile,BufRead *.rb call Set_No_Tabs(2)
au BufNewFile,BufRead *.py call Set_No_Tabs(4)
au BufNewFile,BufRead *.puuro call Set_No_Tabs(4)
au BufNewFile,BufRead *.js call Set_No_Tabs(4)
au BufNewFile,BufRead *.ts call Set_No_Tabs(4)
au BufNewFile,BufRead *.scm call Set_No_Tabs(2)

au BufNewFile,BufRead *.java call Set_No_Tabs(4)

au BufNewFile,BufRead *.ino call Set_No_Tabs(4)
au BufNewFile,BufRead *.cpp,*.hpp call Set_No_Tabs(4)
au BufNewFile,BufRead *.cc,*.hh call Set_No_Tabs(4)
au BufNewFile,BufRead *.c,*.h call Set_No_Tabs(4)
au BufNewFile,BufRead *.cs call Set_No_Tabs(4)

au BufNewFile,BufRead *.cu call Set_No_Tabs(4)

au BufNewFile,BufRead *.glsl call Set_No_Tabs(4)
au BufNewFile,BufRead *.frag,*.vert,*.fp,*.vp,*.glsl,*.vjs set syntax=glsl 

au BufNewFile,BufRead *.cu set syntax=cuda
au BufNewFile,BufRead *.ino set syntax=cpp

au BufNewFile,BufRead *.mac set syntax=maxima

au BufNewFile,BufRead *.haex set syntax=haex
au BufNewFile,BufRead *.haex call Set_No_Tabs(4)

au BufNewFile,BufRead *.nut set syntax=squirrel
au BufNewFile,BufRead *.nut call Set_No_Tabs(4)

au BufNewFile,BufRead *.pls set syntax=pls

au BufNewFile,BufRead *.lua call Set_No_Tabs(4)
au BufNewFile,BufRead *.kk call Set_No_Tabs(4)

au BufNewFile,BufRead *.kip call Set_No_Tabs(4)
au BufNewFile,BufRead *.kip set syntax=kip
set errorformat+=ERROR\ %f:%l.%c\ %m

au BufNewFile,BufRead *.json call Set_No_Tabs(4)

au BufNewFile,BufRead CMakeLists.txt call Set_No_Tabs(4)

au FileType gitcommit set tw=70

"
" glsl real-time updating
"

set updatetime=500

function SaveCandidate()
  if exists("b:needToUpdateCandidate") && b:needToUpdateCandidate == 1
    let save_modified = &modified
    silent! execute 'write!' expand("%:p") . ".update_candidate"
    let &modified = save_modified
    let b:needToUpdateCandidate = 0
  end
endfunction

" Disabled to avoid garbaging.
"au TextChanged,TextChangedI *.glsl,*.css let b:needToUpdateCandidate = 1
"au CursorHold,CursorHoldI *.glsl,*.css call SaveCandidate()

"
" Key bindings
"

map <F2> <Esc>:bp<CR>
map <F3> <Esc>:bn<CR>

map <F5><F5> <Esc>"*p
map <F5><F1> <Esc>"*p

map <F6> <Esc>zzmx:%!$(git rev-parse --show-toplevel)/clang-format.sh<CR>`xzz

set makeprg=scons
map <F7> <Esc>:wa<CR>:make -j1 -C $(git rev-parse --show-toplevel) errorcompile=1<CR>
map <F8> <Esc>:wa<CR>:make -j1 errorcompile=1<CR>

map <F4><F1> <Esc>:YcmCompleter GoToDeclaration<CR>
map <F4><F2> <Esc>:YcmCompleter GoToDefinition<CR>
map <F4><F3> <Esc>:YcmCompleter GoToReferences<CR>
map <F4><F4> <Esc>:YcmCompleter GoTo<CR>
map <F4>1 <Esc>:YcmCompleter GoToInclude<CR>
map <F4>2 <Esc>:YcmCompleter FixIt<CR>
