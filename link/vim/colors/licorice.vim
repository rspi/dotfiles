" Name: Licorice Vim Colorscheme
" Author: Rasmus Spiegelberg <rsp@outlook.com>
" Created: Nov, 2012
" License: MIT 
"
" This color scheme is based on the following 16 colors.
" To use this in a terminal environment,
" set your terminal colors accordingly.
" 
" fg:  #cccccc
" bg:  #1e2426
"
" 0:   #191f21
" 1:   #ef2929
" 2:   #8ae234
" 3:   #fcaf3e
" 4:   #1793d1
" 5:   #656763
" 6:   #2e3436
" 7:   #cccccc
" 8:   #444444
" 9:   #f47070
" 10:  #b1ec78
" 11:  #fdca81
" 12:  #729fcf
" 13:  #888a85
" 14:  #3f4b4d
" 15:  #ffffff

set background=dark
set t_Co=16

hi clear
if exists("syntax_on")
  syntax reset
endif

let colors_name = "licorice"

" Basic
hi Normal        guifg=#cccccc guibg=#1e2426          ctermfg=7  ctermbg=none
hi NonText       guifg=#3f4b4d guibg=#1e2426 gui=none ctermfg=14 ctermbg=none
hi Cursor                      guibg=#cccccc                     ctermbg=7
hi ICursor                     guibg=#cccccc                     ctermbg=7
hi CursorLine                  guibg=#191f21                     ctermbg=0     cterm=none
hi ColorColumn                 guibg=#191f21                     ctermbg=0
hi Visual                      guibg=#444444                     ctermbg=8
hi LineNr        guifg=#3f4b4d guibg=#1e2426          ctermfg=14 ctermbg=none
hi MoreMsg       guifg=#729fcf                        ctermfg=10
hi Question      guifg=#8ae234               gui=none ctermfg=10
hi WildMenu      guifg=#cccccc guibg=#191f21          ctermfg=7  ctermbg=0
hi SignColumn                  guibg=#1e2426                     ctermbg=none

" Search
hi IncSearch     guifg=#fcaf3e guibg=#444444          ctermfg=3  ctermbg=8
hi Search        guifg=#fcaf3e guibg=#444444          ctermfg=3  ctermbg=8

" Window Elements
hi StatusLine    guifg=#cccccc guibg=#444444 gui=none ctermfg=7  ctermbg=8     cterm=none
hi StatusLineNC  guifg=#888a85 guibg=#444444 gui=none ctermfg=13 ctermbg=8     cterm=none
hi VertSplit     guifg=#444444 guibg=#444444 gui=none ctermfg=8  ctermbg=8     cterm=none

" Pmenu
hi Pmenu         guifg=#cccccc guibg=#2e3436          ctermfg=7  ctermbg=6
hi PmenuSel      guifg=#1e2426 guibg=#ffffff          ctermfg=0  ctermbg=15
hi PmenuSbar                   guibg=#444444                     ctermbg=8
hi PmenuThumb    guifg=#ffffff                        ctermfg=15

" Folds
hi Folded        guifg=#cccccc guibg=#2e3436          ctermfg=7  ctermbg=6

" Specials
hi Title         guifg=#fcaf3e                        ctermfg=3
hi SpecialKey    guifg=#3f4b4d                        ctermfg=14

" Tabs
hi TabLine       guifg=#888a85 guibg=#444444 gui=none ctermfg=13 ctermbg=8     cterm=none
hi TabLineFill   guifg=#444444                        ctermfg=8
hi TabLineSel    guifg=#cccccc guibg=#1e2426 gui=none ctermfg=7  ctermbg=none  cterm=none
hi TabWinNumSel  guifg=#cccccc guibg=#1e2426 gui=none ctermfg=7  ctermbg=none  cterm=none
hi TabNumSel     guifg=#cccccc guibg=#1e2426 gui=none ctermfg=7  ctermbg=none  cterm=none
hi TabWinNum     guifg=#888a85 guibg=#444444 gui=none ctermfg=13 ctermbg=8     cterm=none
hi TabNum        guifg=#888a85 guibg=#444444 gui=none ctermfg=13 ctermbg=8     cterm=none

" Matches
hi MatchParen    guifg=#1e2426 guibg=#fcaf3e          ctermfg=0  ctermbg=3

" Tree
hi Directory     guifg=#ffffff                        ctermfg=15

" Diff
hi DiffDelete    guifg=#cccccc guibg=#f47070 gui=none ctermfg=7  ctermbg=9     cterm=none
hi DiffAdd       guifg=#1e2426 guibg=#b1ec78 gui=none ctermfg=0  ctermbg=10    cterm=none
hi DiffChange                  guibg=#2e3436 gui=none            ctermbg=6     cterm=none
hi DiffText                    guibg=#2e3436 gui=none            ctermbg=6     cterm=none

" Spell
hi SpellBad                                           ctermfg=1  ctermbg=none  cterm=underline
hi SpellCap                                           ctermfg=11 ctermbg=none  cterm=underline
hi SpellRare                                          ctermfg=11 ctermbg=none  cterm=underline

" Syntax
hi Comment       guifg=#656763                        ctermfg=5
hi Constant      guifg=#8ae234                        ctermfg=2
hi Number        guifg=#8ae234                        ctermfg=2
hi Statement     guifg=#729fcf               gui=none ctermfg=12               cterm=none 
hi Identifier    guifg=#729fcf                        ctermfg=12
hi Type          guifg=#729fcf               gui=none ctermfg=12               cterm=none
hi PreProc       guifg=#fcaf3e                        ctermfg=3
hi Function      guifg=#fcaf3e                        ctermfg=3
hi Todo          guifg=#fcaf3e guibg=bg               ctermfg=3  ctermbg=none
hi Keyword       guifg=#ffffff                        ctermfg=15
hi Special       guifg=#ffffff                        ctermfg=15
hi Error         guifg=#ffffff guibg=#ef2929          ctermfg=15 ctermbg=1

" --------------------------------------------------------------------------------------------

" HTML
hi htmlTag       guifg=#888a85                        ctermfg=13
hi htmlTagName   guifg=#cccccc                        ctermfg=7
hi link htmlEndTag htmlTag
hi link htmlSpecialTagName htmlTagName

" JavaScript
hi link javaScriptBraces htmlTag

" CSS
hi link cssBraces htmlTag

" Vimwiki
hi link VimwikiPre htmlTag
