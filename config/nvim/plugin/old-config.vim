" set encoding=utf-8
set backspace=indent,eol,start
set nocompatible
set exrc
" let mapleader = ','

set showcmd         " show current command input
set hidden          " does not force you to write or undo on :e
set autoread
set autowrite
set noswapfile
set nobackup
set nowritebackup
set history=200
set nrformats=      " use decimal notion rather then octal 07+01=08
set laststatus=0
set noruler
" set complete=.,w,b " not needed?

" set number " set in options
set scrolloff=2
noremap j gj
noremap k gk
noremap <c-e> 2<c-e>
noremap <c-y> 2<c-y>
imap <C-C> <esc>
" set mouse=nicr " has sensible default in neovim

set autoindent
set tabstop=2       " width of a tab char
set shiftwidth=2    " tunes amount of spaces
set softtabstop=2   " tunes amount of spaces for indentation (< >)
set expandtab       " spaces in place of tab chars
set nowrap
set linebreak

set gdefault        " set /g as default
set inccommand=nosplit "sub command preview
set ignorecase
set smartcase
set incsearch
set hlsearch
nnoremap <silent><C-C> :noh<cr>

" set foldmethod=marker
set foldmethod=manual
set foldlevel=100
set nofoldenable
set foldmarker={,}

nnoremap <silent><C-H> gT
nnoremap <silent><C-L> gt
nnoremap gT :-tabmove<cr>
nnoremap gt :+tabmove<cr>

" Make star search lovely
" http://www.vim.org/scripts/script.php?script_id=4335
function! s:VStarsearch_searchCWord()
	let wordStr = expand("<cword>")
	if strlen(wordStr) == 0
		echohl ErrorMsg
		echo 'E348: No string under cursor'
		echohl NONE
		return
	endif
	if wordStr[0] =~ '\<'
		let @/ = '\<' . wordStr . '\>'
	else
		let @/ = wordStr
	endif
	let savedUnnamed = @"
	let savedS = @s
	normal! "syiw
	if wordStr != @s
		normal! w
	endif
	let @s = savedS
	let @" = savedUnnamed
endfunction
function! s:VStarsearch_searchVWord()
	let savedUnnamed = @"
	let savedS = @s
	normal! gv"sy
	let @/ = '\V' . substitute(escape(@s, '\'), '\n', '\\n', 'g')
	let @s = savedS
	let @" = savedUnnamed
endfunction
nnoremap <silent> * :call <SID>VStarsearch_searchCWord()<cr>:set hls<cr>
vnoremap <silent> * :<C-u>call <SID>VStarsearch_searchVWord()<cr>:set hls<cr>

" Spell-Menu dropdown
:nnoremap <leader>s a<C-X><C-S>

" quit :help with q
function! QuitWithQ()
  if &buftype == 'help'
    nnoremap <buffer> <silent> q :q<cr>
    nnoremap <buffer> <silent><C-C> :q<cr>
  endif
endfunction
autocmd FileType help exe QuitWithQ()

" Make sure Vim returns to the same line when you reopen a file.
augroup line_return
  au!
  au BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \ execute 'normal! g`"zvzz' |
    \ endif
augroup END

" show element highlight group.
nmap <leader>z :call <SID>SynStack()<cr>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" Yank filename
nmap yp :let @" = expand("%:t")<cr>

" Resize splits when the window is resized
au VimResized * :wincmd =

" command W :execute ':silent w !sudo tee % > /dev/null' | :edit!
cnoremap WW w !sudo tee > /dev/null %

" Toggle between text/code mode.
let g:textModeEnabled = 0
function! TextModeToggle(lang)
  if g:textModeEnabled && a:lang == 'none'
    setlocal nospell
    setlocal nowrap
    let g:textModeEnabled = 0
  else
    if a:lang == 'sv'
      setlocal spelllang=sv
    else
      setlocal spelllang=en
    endif
    setlocal spell
    setlocal wrap
    let g:textModeEnabled = 1
  endif
endfunction
nnoremap <leader>t :call TextModeToggle("none")<cr>
nnoremap <leader>te :call TextModeToggle("en")<cr>
nnoremap <leader>ts :call TextModeToggle("sv")<cr>

autocmd BufNewFile,BufRead COMMIT_EDITMSG call TextModeToggle("en")
command! -range=% FormatJSON <line1>,<line2>!jq
command! -range=% FormatXML <line1>,<line2>!xmllint --format %
