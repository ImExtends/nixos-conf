autocmd Filetype python nnoremap <buffer> <F5> :w<CR>:terminal python3 "%"<CR>
autocmd Filetype sh nnoremap <buffer> <F5> :w<CR>:terminal ./%"<CR>
autocmd Filetype rust nnoremap <buffer> <F5> :w<CR>:terminal cargo run ..<CR>
autocmd Filetype go nnoremap <buffer> <F5> :w<CR>:terminal go run src/main.go <CR>
autocmd Filetype elixir nnoremap <buffer> <F5> :w<CR>:terminal elixir "%" <CR>
autocmd Filetype java nnoremap <buffer> <F5> :w<CR>:terminal javac Main.java && java Main<CR>
autocmd Filetype haskell nnoremap <buffer> <F5> :w<CR>:terminal stack run<CR>
autocmd Filetype haskell nnoremap <buffer> <F2> :w<CR>:terminal ghc --make "%"<CR>
inoremap jk <esc>
nmap <S-Enter> O<Esc>

" Nerdtree config
map <silent> <C-x> :NERDTreeToggle<CR>
let NERDTreeIgnore=['\.pyc$', '\~$', '__pycache__']
let NERDTreeWinSize=20

" Going through a file
imap <c-space> <Plug>(asyncomplete_force_refresh)
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"
inoremap \<cr> <cr><c-o>0

tnoremap <Esc> <C-\><C-n>:q!<CR>
vmap <C-c> "+y
