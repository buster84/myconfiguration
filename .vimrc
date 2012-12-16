filetype on  " Automatically detect file types.
set nocompatible  " no vi compatibility.

" Add recently accessed projects menu (project plugin)
set viminfo^=\!

" Minibuffer Explorer Settings
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

" alt+n or alt+p to navigate between entries in QuickFix
map <silent> <m-p> :cp <cr>
map <silent> <m-n> :cn <cr>

" Change which file opens after executing :Rails command
let g:rails_default_file='config/database.yml'

syntax enable

set cf  " Enable error files & error jumping.
set clipboard+=unnamed  " Yanks go on clipboard instead.
set history=256  " Number of things to remember in history.
set autowrite  " Writes on make/shell commands
set ruler  " Ruler on
set nu  " Line numbers on
set nowrap  " Line wrapping off
set timeoutlen=250  " Time to wait after ESC (default causes an annoying delay)
" colorscheme vividchalk  " Uncomment this to set a default theme

" Formatting
set ts=2  " Tabs are 2 spaces
set bs=2  " Backspace over everything in insert mode
set shiftwidth=2  " Tabs under smart indent
set nocp incsearch
set cinoptions=:0,p0,t0
set cinwords=if,else,while,do,for,switch,case
set formatoptions=tcqr
set cindent
set autoindent
set smarttab
set expandtab

" Visual
set showmatch  " Show matching brackets.
set mat=5  " Bracket blinking.
set list
" Show $ at end of line and trailing space as ~
set lcs=tab:\ \ ,eol:$,trail:~,extends:>,precedes:<
set novisualbell  " No blinking .
set noerrorbells  " No noise.
set laststatus=2  " Always show status line.

" gvim specific
set mousehide  " Hide mouse after chars typed
set mouse=a  " Mouse in all modesc
 
if &term == "screen"
  set ttymouse=xterm2
endif
 

set backupdir=$HOME/.vim-backup
let &directory = &backupdir
set hlsearch


set ignorecase
set smartcase
 
" for utf-8
set termencoding=utf-8
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
 
highlight ZenkakuSpace cterm=underline ctermfg=lightgreen guibg=#666666
au BufNewFile,BufRead * match ZenkakuSpace /　/

function SetMyAutoComplete ()
  let w:MyAutoCompleteFlag = exists('w:MyAutoCompleteFlag') ? !w:MyAutoCompleteFlag : 1
 
  if w:MyAutoCompleteFlag
    inoremap { {<RETURN>}<UP><ESC>$
    inoremap [ []<LEFT>
    inoremap ( ()<LEFT><SPACE><SPACE><LEFT>
    inoremap " ""<ESC>
    inoremap ' ''<ESC>
    inoremap <C-h> <LEFT>
    inoremap <C-j> <DOWN>
    inoremap <C-k> <UP>
    inoremap <C-l> <RIGHT>
    vnoremap { "zdi^V{<C-R>z}<ESC>
    vnoremap [ "zdi^V[<C-R>z]<ESC>
    vnoremap ( "zdi^V(<C-R>z)<ESC>
    vnoremap " "zdi^V"<C-R>z^V"<ESC>
    vnoremap ' "zdi'<C-R>z'<ESC>
 
    "inoremap <TAB> <C-P>
 
  else
    iunmap {
    iunmap [
    iunmap (
    iunmap "
    iunmap '
    iunmap <C-h>
    iunmap <C-j>
    iunmap <C-k>
    iunmap <C-l>
    vunmap {
    vunmap [
    vunmap (
    vunmap "
    vunmap '
 
    "iunmap <TAB>
 
  endif
endfunction
 
call SetMyAutoComplete()
 
function AlignAssignments ()
    "Patterns needed to locate assignment operators...
    let ASSIGN_OP   = '\([-+*/%|&]\?=\@<!=[=~]\@!\)\|,'
    let ASSIGN_LINE = '^\(.\{-}\)\s*\(' . ASSIGN_OP . '\)'
 
    "Locate block of code to be considered (same indentation, no blanks)
    let indent_pat = '^' . matchstr(getline('.'), '^\s*') . '\S'
    let firstline  = search('^\%('. indent_pat . '\)\@!','bnW') + 1
    let lastline   = search('^\%('. indent_pat . '\)\@!', 'nW') - 1
    if lastline < 0
        let lastline = line('$')
    endif
 
    "Find the column at which the operators should be aligned...
    let max_align_col = 0
    let max_op_width  = 0
    for linetext in getline(firstline, lastline)
        "Does this line have an assignment in it?
        let left_width = match(linetext, '\s*' . ASSIGN_OP)
 
        "If so, track the maximal assignment column and operator width...
        if left_width >= 0
            let max_align_col = max([max_align_col, left_width])
 
            let op_width      = strlenline('.'), '^\s*') . '\S'
    let firstline  = search('^\%('. indent_pat . '\)\@!','bnW') + 1
    let lastline   = search('^\%('. indent_pat . '\)\@!', 'nW') - 1
    if lastline < 0
        let lastline = line('$')
    endif
 
    "Find the column at which the operators should be aligned...
    let max_align_c sndent_pat . '\)\@!','bnW') + 1
    let lastline   = search('^ the appropriate column...
    for linenum in range(firstline, lastline)
        let oldline = getline(linenum)
        let newline = substitute(oldline, ASSIGN_LINE, FORMATTER, "")
        call setline(linenum, newline)
    endfor
endfunction
 
nmap <silent> ;= :call AlignAssignments()<CR>
nmap <silent> <C-M> :call SetMyAutoComplete()<CR>

