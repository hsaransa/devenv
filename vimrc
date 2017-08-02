" vim configuration file
" 2014-10-29

" Screw the old vim
set nocompatible

filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'Valloric/YouCompleteMe'
call vundle#end()            " required
filetype plugin indent on    " required

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
"colorscheme darkblue
colorscheme default
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

au FileType gitcommit set tw=70

" glsl real-time updating

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

map <F5> <Esc>:w<CR>

map <F6> <Esc>:%!$(git rev-parse --show-toplevel)/external/clangformat/linux/clang-format -style file<CR>
set makeprg=scons
map <F7> <Esc>:wa<CR>:make -j1 -C $(git rev-parse --show-toplevel) errorcompile=1<CR>
map <F8> <Esc>:wa<CR>:make -j1 errorcompile=1<CR>

"
" Perforce auto check-out
"

" Set a buffer-local variable to the perforce path, if this file is under the perforce root.
function IsUnderPerforce()
  if exists("$P4HOME")
    if expand("%:p") =~ ("^" . $P4HOME)
      let b:p4path = substitute(expand("%:p"), $P4HOME, "//depot", "")
    endif
  endif
endfunction

" Confirm with the user, then checkout a file from perforce.
function P4Checkout()
  if exists("b:p4path")
"    if (confirm("Checkout from Perforce?", "&Yes\n&No", 1) == 1)
      call system("p4 edit " . b:p4path . " > /dev/null")
      if v:shell_error == 0
        set noreadonly
      endif
"    endif
  endif
endfunction

if !exists("au_p4_cmd")
  let au_p4_cmd=1
  au BufEnter * call IsUnderPerforce()
  au FileChangedRO * call P4Checkout()
endif

