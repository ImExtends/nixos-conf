" Some basic config
syntax on
set autoindent
let python_highlight_all=1
set number relativenumber
set tabstop=8
set mouse=a
set listchars=tab:>-,trail:~,extends:>,precedes:<,space:.
set list
set guifont=Fira\ Code\ Retina:12

" Colorscheme options
set t_Co=256
set background=dark
colorscheme gruvbox
let g:gruvbox_contrast_dark="hard"
let g:gruvbox_contrast_light="soft"

if (has("termguicolors"))
	set termguicolors
endif

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Enable block cursor
let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"
